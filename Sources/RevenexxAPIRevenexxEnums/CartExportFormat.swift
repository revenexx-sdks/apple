import Foundation

public enum CartExportFormat: String, CustomStringConvertible {
    case json = "json"
    case csv = "csv"

    public var description: String {
        return rawValue
    }
}
