import Foundation

public enum CustomersOrganizationsListStatus: String, CustomStringConvertible {
    case active = "active"
    case blocked = "blocked"

    public var description: String {
        return rawValue
    }
}
