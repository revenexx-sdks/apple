import Foundation

public enum ProductsKind: String, CustomStringConvertible {
    case simple = "simple"
    case model = "model"
    case variant = "variant"

    public var description: String {
        return rawValue
    }
}
