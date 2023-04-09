// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PMBinary",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(
            name: "PMSwiftLint",
            targets: ["SwiftLintBinary"]
        ),
        .executable(
            name: "PMSourcery",
            targets: ["SourceryBinary"]
        ),
        .executable(
            name: "PMXcodegen",
            targets: ["XcodegenBinary"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .binaryTarget(name: "SwiftLint"),
        .binaryTarget(name: "Sourcery"),
        .binaryTarget(name: "Xcodegen")
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
