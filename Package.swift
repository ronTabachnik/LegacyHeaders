// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "LegacyHeaders",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LegacyHeaders",
            targets: ["LegacyHeaders"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LegacyHeaders",
            dependencies: [],
            path: "Sources/LegacyHeaders",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("Masonry"),
            ]
        )
    ]
)
