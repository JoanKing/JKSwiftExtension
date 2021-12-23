// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "JKSwiftExtension",
    platforms: [.iOS(.v9.0)],
    products: [
        .library(name: "JKSwiftExtension", targets: ["JKSwiftExtension"])
    ],
    targets: [
        .target(
            name: "JKSwiftExtension",
            path: "Sources"
        )
    ]
)
