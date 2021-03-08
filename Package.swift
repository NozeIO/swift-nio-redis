// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "swift-nio-redis-client",
    products: [
        .library(name: "Redis", targets: [ "Redis" ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", 
                 from: "2.20.0"),
        .package(url: "https://github.com/SwiftNIOExtras/swift-nio-redis.git", 
                 from: "0.10.3")
    ],
    targets: [
        .target    (name: "Redis",      dependencies: [ "NIORedis" ]),
        .testTarget(name: "RedisTests", dependencies: [ "Redis"    ])
    ]
)
