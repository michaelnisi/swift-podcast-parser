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

final class PodcastParserTests: XCTestCase {
  func testTag() throws {
    let input = """
    <rss
        xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
        xmlns:googleplay="http://www.google.com/schemas/play-podcasts/1.0"
        xmlns:content="http://purl.org/rss/1.0/modules/content/"
        xmlns:atom="http://www.w3.org/2005/Atom"
        xmlns:spotify="http://www.spotify.com/ns/rss"
        xmlns:psc="http://podlove.org/simple-chapters/"
        xmlns:media="https://search.yahoo.com/mrss/"
        version="2.0">
    """
    
    XCTAssertNoThrow(try openingTagParser.parse(input))
  }
  
  func testComment() throws {
    let input = "<!-- hello --> \n   "
    let xml = try commentParser.parse(input)
    
    XCTAssertEqual(xml, .comment("hello "))
  }
  
  func testTagName() throws {
    let tagNames = ["link", "atom:link"]
    let wanted = ["link", "atom:link"]
    
    for (i, tagName) in tagNames.enumerated() {
      let xml = try tagNameParser.parse(tagName)
      
      XCTAssertEqual(xml, wanted[i])
    }
  }
}
