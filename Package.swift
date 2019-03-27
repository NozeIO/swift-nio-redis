// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "swift-nio-redis-client",
    products: [
        .library(name: "Redis", targets: [ "Redis" ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", 
                 from: "1.13.2"),
        .package(url: "https://github.com/SwiftNIOExtras/swift-nio-redis.git", 
                 from: "0.9.0")
    ],
    targets: [
        .target    (name: "Redis",      dependencies: [ "NIORedis" ]),
        .testTarget(name: "RedisTests", dependencies: [ "Redis"    ])
    ]
)
