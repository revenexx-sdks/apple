import Foundation

public enum CartItemType: String, CustomStringConvertible {
    case product = "product"
    case configuration = "configuration"
    case custom = "custom"

    public var description: String {
        return rawValue
    }
}
