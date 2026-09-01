import Foundation

public enum ContactUpdateRequestRegistrationStatus: String, CustomStringConvertible {
    case pending = "pending"
    case approved = "approved"

    public var description: String {
        return rawValue
    }
}
