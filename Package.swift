// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BindKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BindKit",
            targets: ["BindKit"]
        ),
    ],
    targets: [
        .target(
            name: "BindKit"
        ),
        .testTarget(
            name: "BindKitTests",
            dependencies: ["BindKit"]
        ),
    ]
)
