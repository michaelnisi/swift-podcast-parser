import Parsing
import CasePaths

let cdataParser = ParsePrint {
  "<![CDATA[".utf8
  Whitespace()
  PrefixUpTo("]]>".utf8)
  "]]>".utf8
  Whitespace()
}
.map(.string)
.map(/XML.Node.cdata)
