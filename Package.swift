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
            .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.0.0") // ✅
        ],
    targets: [
        .target(
            name: "LegacyHeaders",
            dependencies: [
                            .product(name: "SDWebImage", package: "SDWebImage")
                        ],
            path: "Sources/LegacyHeaders",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("Masonry"),
                .headerSearchPath("BKMoney"),
                .headerSearchPath("MBProgressHUD"),
            ]
        )
    ]
)
