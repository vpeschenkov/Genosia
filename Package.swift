// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "genosia",
    products: [
        .library(name: "genosia", targets: ["genosia"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "genosia",
            dependencies: ["SwiftCLI"],
            path: "Sources"),
    ]
)
