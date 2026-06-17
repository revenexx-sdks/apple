import Foundation

public enum Priority: String, CustomStringConvertible {
    case normal = "normal"
    case high = "high"

    public var description: String {
        return rawValue
    }
}
