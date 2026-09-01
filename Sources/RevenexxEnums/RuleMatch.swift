import Foundation

public enum RuleMatch: String, CustomStringConvertible {
    case all = "all"
    case any = "any"

    public var description: String {
        return rawValue
    }
}
