// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMCore",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PMCore",
            targets: ["PMCore"]
        ),
        .library(
            name: "PMProtocols",
            targets: ["PMProtocols"]
        )
    ],
    dependencies: [
        .package(local: "PMPlugins"),
        .package(local: "PMExternalLibraries")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PMCore",
            dependencies: [
                .product(name: "PMCoreExternalLibraries", package: "PMExternalLibraries")
            ],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins")
            ]
        ),
        .target(
            name: "PMProtocols",
            dependencies: [],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins")
            ]
        ),
        .testTarget(
            name: "PMCoreTests",
            dependencies: [
                "PMCore",
                .product(name: "PMCoreExternalLibrariesTests", package: "PMExternalLibraries")
            ],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins"),
                .plugin(name: "PMSourceryPlugin", package: "PMPlugins")
            ]
        ),
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
