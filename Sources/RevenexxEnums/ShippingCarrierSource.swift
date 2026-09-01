import Foundation

public enum ShippingCarrierSource: String, CustomStringConvertible {
    case method = "method"
    case methodCode = "method_code"
    case methodText = "method_text"
    case tenantDefault = "tenant_default"
    case tenantDefaultText = "tenant_default_text"

    public var description: String {
        return rawValue
    }
}
