import Foundation

public enum CategoriesRuleMatch: String, CustomStringConvertible {
    case all = "all"
    case any = "any"

    public var description: String {
        return rawValue
    }
}
