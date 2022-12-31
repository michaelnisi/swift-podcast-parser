import Parsing
import CasePaths
import Collections

let contentParser: (Int?) -> AnyParserPrinter<Substring.UTF8View, XML.Node> = { indentation in
  ParsePrint {
    Whitespace(.horizontal).printing(String(repeating: " ", count: indentation ?? 0).utf8)
    OneOf {
      containerTagParser(indentation).map(/XML.Node.element)
      emptyTagParser.map(/XML.Node.element)
      commentParser
      textParser
      cdataParser
    }
    Whitespace()
  }
  .eraseToAnyParserPrinter()
}

let containerTagParser = { (indentation: Int?) in
  ParsePrint {
    openingTagParser
    Whitespace(.vertical).printing(indentation != nil ? "\n".utf8 : "".utf8)
    Many {
      Lazy {
        contentParser(indentation.map { $0 + 4 })
        Whitespace(.vertical).printing(indentation != nil ? "\n".utf8 : "".utf8)
      }
    } terminator: {
      Whitespace(.horizontal).printing(String(repeating: " ", count: indentation ?? 0).utf8)
      "</".utf8
    }
    
    Prefix { $0 != .init(ascii: ">") }.map(.string)
    ">".utf8
    Whitespace()
  }
  .filter { tagHead, _, closingTag in
    tagHead.0 == closingTag
  }
  .map(Conversions.UnpackXMLElementTuple())
  .map(.memberwise(XML.Element.init))
}

public struct PodcastParser: ParserPrinter {
  let parser: AnyParserPrinter<Substring.UTF8View, XML>
  
  public init(indenting: Bool = true) {
    self.parser = ParsePrint {
      Optionally {
        xmlPrologParser
        Whitespace(.vertical)
          .printing(indenting ? "\n".utf8 : "".utf8)
      }
      .map(Conversions.OptionalEmptyDictionary())
      
      Optionally {
        xmlStylesheetParser
        Whitespace(.vertical)
          .printing(indenting ? "\n".utf8 : "".utf8)
      }
      .map(Conversions.OptionalEmptyDictionary())
      
      containerTagParser(indenting ? 0 : nil)
    }
    .map(.memberwise(XML.init(prolog:stylesheet:root:)))
    .eraseToAnyParserPrinter()
  }
  
  public func print(_ output: XML, into input: inout Substring.UTF8View) throws {
    try parser.print(output, into: &input)
  }
  
  public func parse(_ input: inout Substring.UTF8View) throws -> XML {
    try parser.parse(&input)
  }
}
