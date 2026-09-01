import Foundation

public enum ShippingRatesBasisMatrixBasisDefault: String, CustomStringConvertible {
    case weight = "weight"
    case quantity = "quantity"
    case orderValue = "order_value"

    public var description: String {
        return rawValue
    }
}
