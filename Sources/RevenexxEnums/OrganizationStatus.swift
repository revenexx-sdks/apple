import Foundation

public enum OrganizationStatus: String, CustomStringConvertible {
    case active = "active"
    case blocked = "blocked"

    public var description: String {
        return rawValue
    }
}
