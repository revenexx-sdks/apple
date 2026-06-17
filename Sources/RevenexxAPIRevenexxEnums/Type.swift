import Foundation

public enum Type: String, CustomStringConvertible {
    case commit = "commit"
    case branch = "branch"
    case tag = "tag"

    public var description: String {
        return rawValue
    }
}
