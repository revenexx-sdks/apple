import Foundation

public enum Format: String, CustomStringConvertible {
    case csv = "csv"
    case xml = "xml"
    case json = "json"
    case xlsx = "xlsx"

    public var description: String {
        return rawValue
    }
}
