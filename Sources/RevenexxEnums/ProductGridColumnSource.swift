import Foundation

public enum ProductGridColumnSource: String, CustomStringConvertible {
    case column = "column"
    case attribute = "attribute"
    case resolved = "resolved"

    public var description: String {
        return rawValue
    }
}
