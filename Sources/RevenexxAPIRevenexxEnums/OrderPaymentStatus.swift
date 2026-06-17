import Foundation

public enum OrderPaymentStatus: String, CustomStringConvertible {
    case open = "open"
    case pending = "pending"
    case authorized = "authorized"
    case paid = "paid"
    case partiallyPaid = "partially_paid"
    case refunded = "refunded"
    case failed = "failed"

    public var description: String {
        return rawValue
    }
}
