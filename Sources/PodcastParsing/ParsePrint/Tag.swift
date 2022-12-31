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

import Parsing

let tagNameParser = ParsePrint {
  From<Conversions.UTF8ViewToSubstring, Prefix<Substring>>(.substring) {
    Prefix { $0.isLetter || $0 == ":" || $0 == "-" }
  }
  .map(.string)
}

let tagHeadParser = ParsePrint {
  tagNameParser
  Optionally {
    Whitespace()
    attributesParser
  }
  .map(Conversions.OptionalEmptyDictionary())
  Whitespace()
}

let tagParser = ParsePrint {
  "<".utf8
  Not { "/".utf8 }
}

let openingTagParser = ParsePrint {
  tagParser
  Prefix(1...) { $0 != .init(ascii: ">") }.pipe {
    tagHeadParser
    Whitespace()
    Not { "/".utf8 }
  }
  ">".utf8
}

let emptyTagParser = ParsePrint {
  tagParser
  Prefix(1...) { $0 != .init(ascii: ">") }.pipe {
    tagHeadParser
    "/".utf8
  }
  ">".utf8
  Always(Array<XML.Node>())
  Always("")
}
.filter { $0.1.isEmpty }
.map(Conversions.UnpackXMLElementTuple())
.map(.memberwise(XML.Element.init))
