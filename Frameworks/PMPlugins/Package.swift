// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMPlugins",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .plugin(name: "PMSwiftLintPlugin", targets: ["PMSwiftLintPlugin"]),
        .plugin(name: "PMSourceryPlugin", targets: ["PMSourceryPlugin"]),
        .plugin(name: "PMXcodegenPlugin", targets: ["PMXcodegenPlugin"])
    ],
    dependencies: [
        .package(local: "PMBinary")
    ],
    targets: [
        .plugin(
            name: "PMSwiftLintPlugin",
            capability: .buildTool(),
            dependencies: [
                .product(name: "PMSwiftLint", package: "PMBinary")
            ]
        ),
        .plugin(
            name: "PMSourceryPlugin",
            capability: .buildTool(),
            dependencies: [
                .product(name: "PMSourcery", package: "PMBinary")
            ]
        ),
        .plugin(
            name: "PMXcodegenPlugin",
            capability: .command(
                intent: .custom(verb: "xcodegen",
                                description: ""
                               ),
                permissions: [.writeToPackageDirectory(reason: "")]
            ),
            dependencies: [
                .product(name: "PMXcodegen", package: "PMBinary")
            ]
        )
    ]
)

enum Path: String {
    case frameworks = "../"
    case project = "../../"
    case features = "../Features/"
}

extension Package.Dependency {
    static func package(local name: String, path: Path = .frameworks) -> Package.Dependency {
        .package(path: path.rawValue + name)
    }
}

extension Target {
    enum BinaryTargetType: String {
        case artifact = ".artifactbundle"
    }
}
