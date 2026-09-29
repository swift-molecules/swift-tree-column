// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-tree-column",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Tree Column",
            targets: ["Tree Column"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tree.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-store.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-atoms/swift-storage.git", branch: "main", traits: ["Generational", "Memory"]),
        .package(url: "https://github.com/swift-atoms/swift-buffer.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-buffer-linear.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-buffer-ring.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-memory.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-memory-allocation.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Tree Column",
            dependencies: [
                .product(name: "Tree", package: "swift-tree"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Store", package: "swift-store"),
                .product(name: "Storage", package: "swift-storage"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer Linear Primitive", package: "swift-buffer-linear"),
                .product(name: "Buffer Linear Bounded Primitive", package: "swift-buffer-linear"),
                .product(name: "Buffer Ring Primitive", package: "swift-buffer-ring"),
                .product(name: "Memory Allocator Pool", package: "swift-memory-allocation"),
                .product(name: "Memory Pool", package: "swift-memory-allocation"),
                .product(name: "Memory Allocator", package: "swift-memory-allocation"),
                .product(name: "Memory", package: "swift-memory"),
                .product(name: "Ownership Shared Primitive", package: "swift-ownership-shared"),
            ]
        ),
        .testTarget(
            name: "Tree Column Tests",
            dependencies: [
                .product(name: "Tree", package: "swift-tree"),
                "Tree Column",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .enableExperimentalFeature("RawLayout")
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
