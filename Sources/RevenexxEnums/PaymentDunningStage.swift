import Foundation

public enum PaymentDunningStage: String, CustomStringConvertible {
    case `none` = "none"
    case reminder = "reminder"
    case overdue = "overdue"

    public var description: String {
        return rawValue
    }
}
