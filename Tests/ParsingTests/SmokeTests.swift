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

import XCTest
@testable import PodcastParsing

final class SmokeTests: XCTestCase {
  func testFixtures() throws {
    for url in try FileManager.default.allXMLFileURLs() {
      let data = try Data(contentsOf: url)
      let input = String(data: data, encoding: .utf8)!
      
      XCTAssertNoThrow(
        try PodcastParser().parse(input),
        url.lastPathComponent
      )
    }
  }
}

private extension FileManager {
  func allXMLFileURLs() throws -> [URL] {
    try contentsOfDirectory(at: Bundle.module.resourceURL!, includingPropertiesForKeys: nil)
      .filter {
        $0.pathExtension == "xml"
      }
  }
}
