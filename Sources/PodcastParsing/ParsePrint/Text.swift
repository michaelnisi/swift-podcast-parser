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
import CasePaths

let textParser = ParsePrint {
  Whitespace()
  Prefix(1...) {
    $0 != .init(ascii: "<") && $0 != .init(ascii: "\n")
  }
  Whitespace()
}
.map(.string)
.map(/XML.Node.text)
