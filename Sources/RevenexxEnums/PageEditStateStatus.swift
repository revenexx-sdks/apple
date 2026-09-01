import Foundation

public enum PageEditStateStatus: String, CustomStringConvertible {
    case active = "active"
    case scheduled = "scheduled"
    case archived = "archived"
    case published = "published"

    public var description: String {
        return rawValue
    }
}
