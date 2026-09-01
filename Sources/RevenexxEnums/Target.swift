import Foundation

public enum Target: String, CustomStringConvertible {
    case organizations = "organizations"

    public var description: String {
        return rawValue
    }
}
