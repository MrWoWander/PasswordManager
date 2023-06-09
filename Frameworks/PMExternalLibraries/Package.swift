// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMExternalLibraries",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PMMainAppExternalLibraries",
            targets: ["PMExternalLibraries"]),
        .library(
            name: "PMMainAppExternalLibrariesTests",
            targets: ["PMExternalLibrariesTests"]),
        .library(
            name: "PMCoreExternalLibraries",
            targets: ["PMExternalLibraries"]),
        .library(
            name: "PMCoreExternalLibrariesTests",
            targets: ["PMExternalLibrariesTests"]),
        .library(
            name: "PMDSExternalLibraries",
            targets: ["PMExternalLibraries"]),
        .library(
            name: "PMDSExternalLibrariesTests",
            targets: ["PMExternalLibrariesTests"]),
        .library(
            name: "PMFeturesExternalLibrariesTests",
            targets: ["PMExternalLibrariesTests"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "11.2.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PMExternalLibraries",
            dependencies: []),
        .target(
            name: "PMExternalLibrariesTests",
            dependencies: [
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble")
            ])
    ]
)
