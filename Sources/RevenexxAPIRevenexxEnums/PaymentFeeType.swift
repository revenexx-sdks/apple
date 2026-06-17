import Foundation

public enum PaymentFeeType: String, CustomStringConvertible {
    case `none` = "none"
    case fixed = "fixed"
    case percent = "percent"

    public var description: String {
        return rawValue
    }
}
