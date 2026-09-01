import Foundation

public enum PaymentStatus: String, CustomStringConvertible {
    case created = "created"
    case requiresAction = "requires_action"
    case authorized = "authorized"
    case captured = "captured"
    case failed = "failed"
    case cancelled = "cancelled"
    case refunded = "refunded"

    public var description: String {
        return rawValue
    }
}
