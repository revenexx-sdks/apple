import Foundation

public enum Status: String, CustomStringConvertible {
    case invited = "invited"
    case active = "active"
    case blocked = "blocked"

    public var description: String {
        return rawValue
    }
}
