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

let xmlPrologParser = ParsePrint {
  "<?xml".utf8
  Whitespace(1..., .horizontal)
  attributesParser
  Whitespace(.horizontal)
  "?>".utf8
}

let xmlStylesheetParser = ParsePrint {
  "<?xml-stylesheet".utf8
  Whitespace(1..., .horizontal)
  attributesParser
  Whitespace()
  "?>".utf8
  Whitespace()
}
