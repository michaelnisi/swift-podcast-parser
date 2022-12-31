import Parsing
import CasePaths

let contentParser: () -> AnyParserPrinter<Substring.UTF8View, XML.Node> = {
  ParsePrint {
    Whitespace()
    OneOf {
      containerTagParser().map(/XML.Node.element)
      emptyTagParser.map(/XML.Node.element)
      commentParser
      textParser
      cdataParser
    }
    Whitespace()
  }
  .eraseToAnyParserPrinter()
}

let containerTagParser = {
  ParsePrint {
    openingTagParser
    Whitespace()
    Many {
      Lazy {
        contentParser()
        Whitespace()
      }
    } terminator: {
      Whitespace()
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
  
  public init() {
    self.parser = ParsePrint {
      Optionally {
        xmlPrologParser
        Whitespace()
      }
      .map(Conversions.OptionalEmptyDictionary())
      
      Optionally {
        xmlStylesheetParser
        Whitespace()
      }
      .map(Conversions.OptionalEmptyDictionary())
      
      containerTagParser()
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
