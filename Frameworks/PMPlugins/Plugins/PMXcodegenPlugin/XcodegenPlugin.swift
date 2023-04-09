//
//  SourceryPlugin.swift
//  
//
//  Created by Mikhail Ivanov on 01.04.23.
//

import PackagePlugin
import Foundation

@main
struct XcodegenCommandPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        // Run one per target
        let configFilePath = context.package.directory.appending(subpath: "project.yml").string
        let xcodegen = try context.tool(named: "xcodegen").path.string
        guard FileManager.default.fileExists(atPath: configFilePath) else {
            Diagnostics.warning("⚠️ Could not find `project.yml` for target \(context.package.displayName)")
            return
        }

        try run(xcodegen, withConfig: configFilePath)
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

private extension XcodegenCommandPlugin {
    func run(_ executable: String, withConfig configFilePath: String) throws {
        let executableURL = URL(fileURLWithPath: executable)

        let process = Process()
        process.executableURL = executableURL
        process.arguments = getArguments(withConfig: configFilePath)

        try process.run()
        process.waitUntilExit()

        let gracefulExit = process.terminationReason == .exit && process.terminationStatus == 0
        if !gracefulExit {
            throw "🛑 The plugin execution failed with reason: \(process.terminationReason.rawValue) and status: \(process.terminationStatus) "
        }
    }

    func getArguments(withConfig configFilePath: String) -> [String] {
        [
            "generate",
            "--spec",
            configFilePath
        ]
    }
}
