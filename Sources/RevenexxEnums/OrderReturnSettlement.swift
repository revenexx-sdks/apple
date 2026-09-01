import Foundation

public enum OrderReturnSettlement: String, CustomStringConvertible {
    case refund = "refund"
    case partialRefund = "partial_refund"
    case replacement = "replacement"
    case repair = "repair"
    case storeCredit = "store_credit"

    public var description: String {
        return rawValue
    }
}
