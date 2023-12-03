// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SimpleUIList",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SimpleUIList",
            targets: ["SimpleUIList"]
        ),
    ],
    targets: [
        .target(
            name: "SimpleUIList"),
    ]
)
