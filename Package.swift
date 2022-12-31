// swift-tools-version: 5.7

//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-podcast-parser open source project
//
// Copyright (c) 2023 Michael Nisi and collaborators
// Licensed under MIT License
//
// See https://github.com/michaelnisi/swift-podcast-parser/blob/main/LICENSE for license information
//
//===----------------------------------------------------------------------===/

import PackageDescription

let package = Package(
    name: "swift-podcast-parser",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "PodcastParsing",
            targets: ["PodcastParsing"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing", exact: "0.10.0"),
        .package(url: "https://github.com/apple/swift-collections.git", exact: "1.0.2"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", exact: "0.4.0"),
    ],
    targets: [
        .target(
            name: "PodcastParsing",
            dependencies: [
              .product(name: "Parsing", package: "swift-parsing"),
              .product(name: "Collections", package: "swift-collections"),
            ]),
        .testTarget(
          name: "ParsingTests",
          dependencies: [
            "PodcastParsing",
            .product(name: "CustomDump", package: "swift-custom-dump"),
          ],
          resources: [
            .process("Resources")
          ]
        )
    ]
)
