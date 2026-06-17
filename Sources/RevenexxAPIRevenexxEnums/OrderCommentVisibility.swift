import Foundation

public enum OrderCommentVisibility: String, CustomStringConvertible {
    case `internal` = "internal"
    case customer = "customer"

    public var description: String {
        return rawValue
    }
}
