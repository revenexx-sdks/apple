import Foundation

public enum Collection: String, CustomStringConvertible {
    case greetings = "greetings"
    case products = "products"

    public var description: String {
        return rawValue
    }
}
