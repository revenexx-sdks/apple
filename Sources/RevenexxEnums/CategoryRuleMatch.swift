import Foundation

public enum CategoryRuleMatch: String, CustomStringConvertible {
    case all = "all"
    case any = "any"

    public var description: String {
        return rawValue
    }
}
