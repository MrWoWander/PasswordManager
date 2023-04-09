// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMDesignSystem",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PMDesignSystem",
            targets: ["PMDesignSystem"]
        )
    ],
    dependencies: [
        .package(local: "PMCore"),
        .package(local: "PMPlugins"),
        .package(local: "PMExternalLibraries")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PMDesignSystem",
            dependencies: [
                .product(name: "PMCore", package: "PMCore"),
                .product(name: "PMDSExternalLibraries", package: "PMExternalLibraries")
            ],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins")
            ]
        ),
        .testTarget(
            name: "PMDesignSystemTests",
            dependencies: [
                "PMDesignSystem",
                .product(name: "PMCore", package: "PMCore"),
                .product(name: "PMDSExternalLibrariesTests", package: "PMExternalLibraries")
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
    case features = "../Features"
}

extension Package.Dependency {
    static func package(local name: String, path: Path = .frameworks) -> Package.Dependency {
        .package(path: path.rawValue + name)
    }
}
