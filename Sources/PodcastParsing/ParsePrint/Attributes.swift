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

let quotedStringParser = ParsePrint {
  "\"".utf8
  PrefixUpTo("\"".utf8).map(.string)
  "\"".utf8
}

let attributeParser = ParsePrint {
  PrefixUpTo("=".utf8).map(.string)
  "=".utf8
  quotedStringParser
}

let attributesParser = Many {
  attributeParser
} separator: {
  Whitespace()
  Not { "?>".utf8 }
}
.map(Conversions.TuplesToDictionary())
