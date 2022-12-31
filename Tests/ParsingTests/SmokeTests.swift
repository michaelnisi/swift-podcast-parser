import XCTest
@testable import PodcastParsing

final class SmokeTests: XCTestCase {
  func testFixtures() throws {
    for url in try FileManager.default.allXMLFileURLs() {
      let data = try Data(contentsOf: url)
      let input = String(data: data, encoding: .utf8)!
      
      XCTAssertNoThrow(
        try PodcastParser(indenting: true).parse(input),
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
