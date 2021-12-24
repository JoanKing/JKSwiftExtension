// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "JKSwiftExtension",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "JKSwiftExtension",
            targets: ["JKSwiftExtension"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "JKSwiftExtension",
            path: "Sources",
            resources: [.process("Assets/ironman.png")]
        ),
        .testTarget(
            name: "JKSwiftExtensionTests",
            dependencies: ["JKSwiftExtension"]),
    ]
)
