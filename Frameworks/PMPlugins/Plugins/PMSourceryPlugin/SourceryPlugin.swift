//
//  SourceryPlugin.swift
//  
//
//  Created by Mikhail Ivanov on 01.04.23.
//

import PackagePlugin
import Foundation

@main
struct SourceryCommandPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [PackagePlugin.Command] {
        let sourcery = try context.tool(named: "sourcery").path
        return makeBuildCommands(
            sourceryPath: sourcery,
            configPath: target.directory,
            packagePath: context.package.directory,
            pluginPath: context.pluginWorkDirectory,
            targetName: target.name,
            outputFilesDirectory: target.directory
        )
    }
}

// MARK: XcodeBuildToolPlugin
#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin
extension SourceryCommandPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [PackagePlugin.Command] {
        let sourcery = try context.tool(named: "sourcery").path
        let outputFilesDirectory = context.xcodeProject.directory.appending(subpath: target.displayName)
        return makeBuildCommands(
            sourceryPath: sourcery,
            configPath: context.xcodeProject.directory,
            packagePath: nil,
            pluginPath: context.pluginWorkDirectory,
            targetName: target.displayName,
            outputFilesDirectory: outputFilesDirectory
        )
    }
}
#endif

// MARK: - CommandPlugin
extension SourceryCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        // Run one per target
        for target in context.package.targets {
            let configFilePath = target.directory.appending(subpath: ".sourcery.yml").string
            let sourcery = try context.tool(named: "sourcery").path.string
            guard FileManager.default.fileExists(atPath: configFilePath) else {
                Diagnostics.warning("⚠️ Could not find `.sourcery.yml` for target \(target.name)")
                continue
            }

            try run(sourcery, withConfig: configFilePath, cacheBasePath: context.pluginWorkDirectory.string)
        }
    }
}

// MARK: - XcodeProjectPlugin
#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SourceryCommandPlugin: XcodeCommandPlugin {
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        for target in context.xcodeProject.targets {
            guard let configFilePath = target
                .inputFiles
                .filter({ $0.path.lastComponent == ".sourcery.yml" })
                .first?
                .path
                .string else {
                Diagnostics.warning("⚠️ Could not find `.sourcery.yml` in Xcode's input file list")
                return
            }
            let sourcery = try context.tool(named: "sourcery").path.string

            try run(sourcery, withConfig: configFilePath, cacheBasePath: context.pluginWorkDirectory.string)
        }
    }
}
#endif

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

private extension SourceryCommandPlugin {

    func makeBuildCommands(
        sourceryPath: Path,
        configPath: Path,
        packagePath: Path?,
        pluginPath: Path,
        targetName: String,
        outputFilesDirectory: Path
    ) -> [PackagePlugin.Command] {
        let configFilePath: String? = {
            let targetConfigFilePath = configPath.appending(subpath: ".sourcery.yml").string
            if FileManager.default.fileExists(atPath: targetConfigFilePath) {
                return targetConfigFilePath
            }
            guard let packagePath = packagePath else {
                return nil
            }
            let packageConfigFilePath = packagePath.appending(subpath: ".sourcery.yml").string
            guard FileManager.default.fileExists(atPath: packageConfigFilePath) else { return nil }
            return packageConfigFilePath
        }()
        guard let configFilePath = configFilePath else {
            Diagnostics.warning("⚠️ Could not find `.sourcery.yml` for target \(targetName)")
            return []
        }
        return [
            .prebuildCommand(
                displayName: "Run Sourcery",
                executable: sourceryPath,
                arguments: getArguments(
                    withConfig: configFilePath,
                    cacheBasePath: pluginPath.string
                ),
                outputFilesDirectory: outputFilesDirectory
            )
        ]
    }

    func run(_ sourcery: String, withConfig configFilePath: String, cacheBasePath: String) throws {
        let sourceryURL = URL(fileURLWithPath: sourcery)

        let process = Process()
        process.executableURL = sourceryURL
        process.arguments = getArguments(withConfig: configFilePath, cacheBasePath: cacheBasePath)

        try process.run()
        process.waitUntilExit()

        let gracefulExit = process.terminationReason == .exit && process.terminationStatus == 0
        if !gracefulExit {
            throw "🛑 The plugin execution failed with reason: \(process.terminationReason.rawValue) and status: \(process.terminationStatus) "
        }
    }

    func getArguments(withConfig configFilePath: String, cacheBasePath: String) -> [String] {
        [
            "--config",
            configFilePath,
            "--cacheBasePath",
            cacheBasePath
        ]
    }
}
