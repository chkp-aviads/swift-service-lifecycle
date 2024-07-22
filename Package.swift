// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "swift-service-lifecycle",
    products: [
        .library(name: "Lifecycle", targets: ["Lifecycle"]),
        .library(name: "LifecycleNIOCompat", targets: ["LifecycleNIOCompat"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-metrics.git", "1.0.0" ..< "3.0.0"),
        .package(url: "https://github.com/swift-server/swift-backtrace.git", from: "1.1.1"),
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.0.0"),
        .package(url: "https://github.com/chkp-aviads/swift-nio.git", branch: "main")
    ],
    targets: [
        .target(name: "Lifecycle",
                dependencies: [
                    .product(name: "Logging", package: "swift-log"),
                    .product(name: "Metrics", package: "swift-metrics"),
                    .product(name: "Backtrace", package: "swift-backtrace"),
                    .product(name: "Atomics", package: "swift-atomics")
                ]),
        .target(name: "LifecycleNIOCompat", dependencies: ["Lifecycle",
                                                           .product(name: "NIO", package: "swift-nio")]),
        .testTarget(name: "LifecycleTests", dependencies: ["Lifecycle", "LifecycleNIOCompat"]),
    ]
)
