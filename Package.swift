// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "BindKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BindKitDeclarative",
            targets: ["BindKitDeclarative"]
        ),
        .library(
            name: "BindKitLayout",
            targets: ["BindKitLayout"]
        ),
    ],
    targets: [
        // Declarative module
        .target(
            name: "BindKitDeclarative",
            path: "Sources/BindKit/Declarative",
            resources: []
        ),

        // Layout module
        .target(
            name: "BindKitLayout",
            path: "Sources/BindKit/Layout",
            resources: []
        ),

        .testTarget(
            name: "BindKitDeclarativeTests",
            dependencies: ["BindKitDeclarative"],
            path: "Tests/BindKitDeclarativeTests"
        ),
        .testTarget(
            name: "BindKitLayoutTests",
            dependencies: ["BindKitLayout"],
            path: "Tests/BindKitLayoutTests"
        ),
    ]
)
