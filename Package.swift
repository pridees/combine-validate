// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineValidate",
    platforms: [.macOS(.v11), .iOS(.v14), .watchOS(.v7)],
    products: [
        .library(
            name: "CombineValidate",
            targets: ["CombineValidate"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CombineValidate",
            dependencies: []
        ),
        .testTarget(
            name: "CombineValidateTests",
            dependencies: ["CombineValidate"]
        ),
    ]
)
