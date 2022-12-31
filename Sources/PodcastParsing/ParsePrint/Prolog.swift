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
