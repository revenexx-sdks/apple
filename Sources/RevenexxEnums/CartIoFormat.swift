import Foundation

public enum CartIoFormat: String, CustomStringConvertible {
    case json = "json"
    case csv = "csv"

    public var description: String {
        return rawValue
    }
}
