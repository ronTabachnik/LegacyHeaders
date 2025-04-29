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
    dependencies: [
        .package(url: "https://github.com/ronTabachnik/Masonry.git", branch: "main")
    ],
    targets: [
        .target(
            name: "LegacyHeaders",
            dependencies: ["Masonry"],
            path: "Sources/LegacyHeaders",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include")
            ]
        )
    ]
)
