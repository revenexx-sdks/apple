import Foundation

public enum Scope: String, CustomStringConvertible {
    case all = "all"
    case marketing = "marketing"

    public var description: String {
        return rawValue
    }
}
