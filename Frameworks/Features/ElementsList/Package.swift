// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ElementsListFeature",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ElementsListFeature",
            targets: ["ElementsListFeature"]
        ),
    ],
    dependencies: [
        .package(local: "PMCore"),
        .package(local: "PMProtocols"),
        .package(local: "PMPlugins"),
        .package(local: "PMDesignSystem"),
        .package(local: "PMExternalLibraries")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ElementsListFeature",
            dependencies: [
                .product(name: "PMCore", package: "PMCore"),
                .product(name: "PMProtocols", package: "PMProtocols"),
                .product(name: "PMDesignSystem", package: "PMDesignSystem")
            ],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins")
            ]
        ),
        .testTarget(
            name: "ElementsListTests",
            dependencies: [
                .target(name: "ElementsListFeature"),
                .product(name: "PMCore", package: "PMCore"),
                .product(name: "PMDesignSystem", package: "PMDesignSystem"),
                .product(name: "PMFeturesExternalLibrariesTests", package: "PMExternalLibraries")
            ],
            plugins: [
                .plugin(name: "PMSwiftLintPlugin", package: "PMPlugins"),
                .plugin(name: "PMSourceryPlugin", package: "PMPlugins")
            ]
        ),
    ]
)

enum Path: String {
    case frameworks = "../../"
    case project = "../../../"
    case features = "../"
}

extension Package.Dependency {
    static func package(local name: String, path: Path = .frameworks) -> Package.Dependency {
        .package(path: path.rawValue + name)
    }
}
