import Foundation

public enum ContactCreateRequestRegistrationStatus: String, CustomStringConvertible {
    case pending = "pending"
    case approved = "approved"

    public var description: String {
        return rawValue
    }
}
