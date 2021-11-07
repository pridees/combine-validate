// swift-tools-version:5.4
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
        .library(
            name: "CombineValidateExtended",
            targets: ["CombineValidateExtended"]
        ),
//        .library(
//            name: "Examples",
//            targets: ["Examples"]
//        ),
    ],
    dependencies: [],
    targets: [
        // MARK: - CombineValidate
        .target(
            name: "CombineValidate",
            dependencies: []
        ),
        .testTarget(
            name: "CombineValidateTests",
            dependencies: ["CombineValidate"]
        ),
        
        // MARK: - CombineValidateExtended
        .target(
            name: "CombineValidateExtended",
            dependencies: ["CombineValidate"]
        ),
        .testTarget(
            name: "CombineValidateExtendedTests",
            dependencies: ["CombineValidateExtended"]
        ),
        
//        // MARK: - Examples target
//        .target(
//            name: "Examples",
//            dependencies: [
//                .byNameItem(name: "CombineValidate", condition: .none)
//            ]
//        ),
    ]
)
