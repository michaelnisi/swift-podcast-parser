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

let commentParser = ParsePrint {
  "<!--".utf8
  Whitespace()
  PrefixUpTo("-->".utf8)
  "-->".utf8
  Whitespace()
}
.map(.string)
.map(/XML.Node.comment)
