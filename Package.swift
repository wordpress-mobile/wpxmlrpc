// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "wpxmlrpc",
    platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11)],
    products: [
        .library(name: "wpxmlrpc", targets: ["wpxmlrpc"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "wpxmlrpc",
            linkerSettings: [.linkedLibrary("iconv")]
        ),
        .testTarget(
            name: "AllTests",
            dependencies: [.target(name: "wpxmlrpc")],
            resources: [.process("Resources")],
            cSettings: [.headerSearchPath("../../Sources/wpxmlrpc")]
        )
    ]
)
