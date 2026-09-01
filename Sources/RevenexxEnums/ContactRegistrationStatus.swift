import Foundation

public enum ContactRegistrationStatus: String, CustomStringConvertible {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"

    public var description: String {
        return rawValue
    }
}
