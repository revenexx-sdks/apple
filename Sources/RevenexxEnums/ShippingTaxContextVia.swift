import Foundation

public enum ShippingTaxContextVia: String, CustomStringConvertible {
    case tenantDefault = "tenant_default"

    public var description: String {
        return rawValue
    }
}
