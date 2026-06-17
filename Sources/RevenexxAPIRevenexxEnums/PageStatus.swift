import Foundation

public enum PageStatus: String, CustomStringConvertible {
    case draft = "draft"
    case published = "published"
    case archived = "archived"

    public var description: String {
        return rawValue
    }
}
