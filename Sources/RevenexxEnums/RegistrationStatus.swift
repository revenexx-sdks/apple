import Foundation

public enum RegistrationStatus: String, CustomStringConvertible {
    case pending = "pending"
    case approved = "approved"
    case rejected = "rejected"

    public var description: String {
        return rawValue
    }
}
