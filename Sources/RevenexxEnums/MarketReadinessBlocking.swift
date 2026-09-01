import Foundation

public enum MarketReadinessBlocking: String, CustomStringConvertible {
    case locales = "locales"
    case currencies = "currencies"
    case taxClasses = "tax_classes"
    case taxBasis = "tax_basis"

    public var description: String {
        return rawValue
    }
}
