import Foundation

public enum PriceOnRequestReason: String, CustomStringConvertible {
    case notPriced = "not_priced"
    case onRequestEntry = "on_request_entry"
    case anonymousDenied = "anonymous_denied"
    case noIdentity = "no_identity"

    public var description: String {
        return rawValue
    }
}
