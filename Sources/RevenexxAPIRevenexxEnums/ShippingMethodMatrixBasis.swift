import Foundation

public enum ShippingMethodMatrixBasis: String, CustomStringConvertible {
    case weight = "weight"
    case quantity = "quantity"
    case orderValue = "order_value"
    case attribute = "attribute"

    public var description: String {
        return rawValue
    }
}
