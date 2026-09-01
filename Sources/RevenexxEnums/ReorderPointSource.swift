import Foundation

public enum ReorderPointSource: String, CustomStringConvertible {
    case row = "row"
    case `default` = "default"

    public var description: String {
        return rawValue
    }
}
