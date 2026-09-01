import Foundation

public enum OrderReturnStatus: String, CustomStringConvertible {
    case registered = "registered"
    case received = "received"
    case completed = "completed"
    case rejected = "rejected"

    public var description: String {
        return rawValue
    }
}
