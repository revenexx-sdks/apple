import Foundation

public enum PaymentFailureCode: String, CustomStringConvertible {
    case providerUnavailable = "provider_unavailable"
    case providerUnreachable = "provider_unreachable"
    case providerNotConfigured = "provider_not_configured"
    case providerDeclined = "provider_declined"
    case providerError = "provider_error"

    public var description: String {
        return rawValue
    }
}
