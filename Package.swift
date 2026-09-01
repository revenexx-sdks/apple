// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Revenexx",
    platforms: [
        .iOS("15.0"),
        .macOS("11.0"),
        .watchOS("7.0"),
        .tvOS("13.0"),
    ],
    products: [
        .library(
            name: "Revenexx",
            targets: [
                "Revenexx",
                "RevenexxEnums",
                "RevenexxModels",
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
            name: "Revenexx",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOWebSocket", package: "swift-nio"),
                "RevenexxModels",
                "RevenexxEnums",
                "JSONCodable"
            ]
        ),
        .target(
            name: "RevenexxModels",
            dependencies: [
                "RevenexxEnums",
                "JSONCodable"
            ]
        ),
        .target(
            name: "RevenexxEnums"
        ),
        .target(
            name: "JSONCodable"
        ),
        .testTarget(
            name: "RevenexxTests",
            dependencies: [
                "Revenexx"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)