import Parsing
import Collections

extension Conversions {
    struct UnpackXMLElementTuple: Conversion {
        @inlinable
        init() { }
        
        @inlinable
        func apply(_ input: ((String, OrderedDictionary<String, String>), [XML.Node], String)) -> (String, OrderedDictionary<String, String>, [XML.Node]) {
            (input.0.0, input.0.1, input.1)
        }
        
        @inlinable
        func unapply(_ output: (String, OrderedDictionary<String, String>, [XML.Node])) -> ((String, OrderedDictionary<String, String>), [XML.Node], String) {
            ((output.0, output.1), output.2, output.0)
        }
    }
}
