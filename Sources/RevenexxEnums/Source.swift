import Foundation

public enum Source: String, CustomStringConvertible {
    case manual = "manual"
    case rule = "rule"

    public var description: String {
        return rawValue
    }
}
