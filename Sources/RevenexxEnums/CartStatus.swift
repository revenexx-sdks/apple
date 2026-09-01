import Foundation

public enum CartStatus: String, CustomStringConvertible {
    case active = "active"
    case abandoned = "abandoned"
    case ordered = "ordered"
    case merged = "merged"

    public var description: String {
        return rawValue
    }
}
