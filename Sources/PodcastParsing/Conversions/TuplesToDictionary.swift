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
import Collections

extension Conversions {
    struct TuplesToDictionary<Key: Hashable, Value>: Conversion {
        @inlinable
        init() {}
        
        @inlinable
        func apply(_ input: [(Key, Value)]) -> OrderedDictionary<Key, Value> {
            input.reduce(into: [:]) { $0[$1.0] = $1.1 }
        }

        @inlinable
        func unapply(_ output: OrderedDictionary<Key, Value>) -> [(Key, Value)] {
            output.map { $0 }
        }
    }
}
