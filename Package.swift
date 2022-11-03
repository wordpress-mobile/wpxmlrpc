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
            path: "WPXMLRPC",
            linkerSettings: [.linkedLibrary("iconv")]
        ),
        .testTarget(
            name: "Tests",
            dependencies: [.target(name: "wpxmlrpc")],
            path: "WPXMLRPCTest",
            resources: [.process("Test Data")],
            cSettings: [.headerSearchPath("../WPXMLRPC")]
        )
    ]
)
