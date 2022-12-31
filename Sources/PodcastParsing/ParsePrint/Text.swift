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
