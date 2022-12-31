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
