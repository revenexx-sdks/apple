import Foundation

public enum CustomersContactsCreateRegistrationStatus: String, CustomStringConvertible {
    case pending = "pending"
    case approved = "approved"

    public var description: String {
        return rawValue
    }
}
