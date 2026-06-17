import Foundation

public enum ContactStatus: String, CustomStringConvertible {
    case invited = "invited"
    case active = "active"
    case blocked = "blocked"

    public var description: String {
        return rawValue
    }
}
