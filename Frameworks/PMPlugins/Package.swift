// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMPlugins",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .plugin(name: "PMSwiftLintPlugin", targets: ["PMSwiftLintPlugin"]),
        .plugin(name: "PMSourceryPlugin", targets: ["PMSourceryPlugin"])
    ],
    targets: [
        .binaryTarget(name: "SwiftLint"),
        .binaryTarget(name: "Sourcery"),
        .plugin(
            name: "PMSwiftLintPlugin",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .plugin(
            name: "PMSourceryPlugin",
            capability: .buildTool(),
            dependencies: ["SourceryBinary"]
        )
    ]
)

enum Path: String {
    case frameworks = "../"
    case project = "../../"
    case features = "../Features/"

    case binary = "Binary/"
}

extension Target {
    enum BinaryTargetType: String {
        case artifact = ".artifactbundle"
    }

    static func binaryTarget(name: String, type: BinaryTargetType = .artifact) -> Target {
        .binaryTarget(name: name + "Binary", path: Path.binary.rawValue + name + type.rawValue)
    }
}
