import Foundation

public enum Reason: String, CustomStringConvertible {
    case hardBounce = "hard_bounce"
    case complaint = "complaint"
    case unsubscribe = "unsubscribe"
    case manual = "manual"

    public var description: String {
        return rawValue
    }
}
