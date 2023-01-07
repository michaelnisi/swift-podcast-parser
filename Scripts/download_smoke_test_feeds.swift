#!/usr/bin/env swift

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

import Foundation
import TabularData

let feeds = """
https://rss.art19.com/apology-line
http://rss.art19.com/the-daily
https://feeds.fireside.fm/bibleinayear/rss
https://feeds.megaphone.fm/ADL9840290619
http://feeds.wnyc.org/experiment_podcast
https://feeds.megaphone.fm/WWO3519750118
https://rss.acast.com/unraveled
https://audioboom.com/channels/4997220.rss
https://podcastfeeds.nbcnews.com/dateline-nbc
https://lincolnproject.libsyn.com/rss
https://feeds.npr.org/510289/podcast.xml
http://feed.radiodiaries.org/radio-diaries
https://cre.fm/feed/m4a
https://hoerer.podigee.io/feed/mp3
https://minkorrekt.podigee.io/feed/mp3
http://feeds.feedburner.com/pod-save-america
https://podcastfeeds.nbcnews.com/dateline-nbc
https://feeds.megaphone.fm/hubermanlab
https://verbrechen.podigee.io/feed/mp3
https://s1.proxy.wavpub.com/weknownothing.xml
https://feed.ausha.co/b2LXliKJ8N9r
"""

let resources = "Tests/ParsingTests/Resources/"

func makeURL(name: String) -> URL {
  let directory = URL(string: FileManager.default.currentDirectoryPath)!
  var components = URLComponents()
  components.scheme = "file"
  components.path = directory.appendingPathComponent(name).absoluteString
  
  return components.url!
}

struct Fixture: Codable {
  let name: String
  let url: URL
  
  private func copy(at location: URL, to destination: URL) throws -> URL {
    try FileManager.default.copyItem(at: location, to: destination)
    try FileManager.default.removeItem(at: location)
    
    return destination
  }
  
  func download() async throws -> URL {
    let (location, _) = try await URLSession.shared.download(from: url)
    let destination = makeURL(name: "\(resources)\(name)")

    return try copy(at: location, to: destination)
  }
  
  static func createResourcesDirectory() {
    do {
      try FileManager.default.createDirectory(at: makeURL(name: resources), withIntermediateDirectories: false)
    } catch {
      //
    }
  }
  
  static func removeAll() throws {
    createResourcesDirectory()
    
    let dir = makeURL(name: resources)
    let urls = try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
    
    for url in urls {
      try FileManager.default.removeItem(at: url)
    }
  }
  
  static func readAll() throws -> [Fixture] {
    try DataFrame(csvData: feeds.data(using: .utf8)!, options: .init(hasHeaderRow: false))
      .rows
      .map {
        .init(name: "\(UUID().uuidString).xml", url: .init(string: $0[0, String.self]!)!)
      }
  }
}

do {
  try Fixture.removeAll()
  
  for fixture in try Fixture.readAll() {
    print(try await fixture.download().lastPathComponent)
  }
} catch {
  print(error)
}
