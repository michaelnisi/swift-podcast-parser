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
