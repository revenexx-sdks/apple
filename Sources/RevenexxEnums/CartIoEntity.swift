import Foundation

public enum CartIoEntity: String, CustomStringConvertible {
    case carts = "carts"
    case cartItems = "cart_items"

    public var description: String {
        return rawValue
    }
}
