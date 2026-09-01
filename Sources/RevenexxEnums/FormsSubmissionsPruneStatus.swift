import Foundation

public enum FormsSubmissionsPruneStatus: String, CustomStringConvertible {
    case new = "new"
    case read = "read"
    case archived = "archived"
    case spam = "spam"

    public var description: String {
        return rawValue
    }
}
