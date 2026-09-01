import Foundation

public enum Collection: String, CustomStringConvertible {
    case products = "products"

    public var description: String {
        return rawValue
    }
}
