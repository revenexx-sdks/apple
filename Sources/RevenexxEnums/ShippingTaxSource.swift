import Foundation

public enum ShippingTaxSource: String, CustomStringConvertible {
    case method = "method"
    case tenantClass = "tenant_class"
    case marketDefault = "market_default"
    case tenantDefault = "tenant_default"

    public var description: String {
        return rawValue
    }
}
