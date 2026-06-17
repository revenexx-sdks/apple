// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RevenexxAPIRevenexx",
    platforms: [
        .iOS("15.0"),
        .macOS("11.0"),
        .watchOS("7.0"),
        .tvOS("13.0"),
    ],
    products: [
        .library(
            name: "RevenexxAPIRevenexx",
            targets: [
                "RevenexxAPIRevenexx",
                "RevenexxAPIRevenexxEnums",
                "RevenexxAPIRevenexxModels",
                "JSONCodable"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.19.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.58.0"),
    ],
    targets: [
        .target(
            name: "RevenexxAPIRevenexx",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOWebSocket", package: "swift-nio"),
                "RevenexxAPIRevenexxModels",
                "RevenexxAPIRevenexxEnums",
                "JSONCodable"
            ]
        ),
        .target(
            name: "RevenexxAPIRevenexxModels",
            dependencies: [
                "RevenexxAPIRevenexxEnums",
                "JSONCodable"
            ]
        ),
        .target(
            name: "RevenexxAPIRevenexxEnums"
        ),
        .target(
            name: "JSONCodable"
        ),
        .testTarget(
            name: "RevenexxAPIRevenexxTests",
            dependencies: [
                "RevenexxAPIRevenexx"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)