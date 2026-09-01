import Foundation

public enum PriceVocabularyRefName: String, CustomStringConvertible {
    case listStatuses = "list-statuses"
    case priceTypes = "price-types"
    case taxBases = "tax-bases"

    public var description: String {
        return rawValue
    }
}
