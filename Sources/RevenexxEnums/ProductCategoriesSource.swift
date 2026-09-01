import Foundation

public enum ProductCategoriesSource: String, CustomStringConvertible {
    case manual = "manual"
    case rule = "rule"

    public var description: String {
        return rawValue
    }
}
