import Foundation

public enum PricesVocabulariesGetName: String, CustomStringConvertible {
    case listStatuses = "list-statuses"
    case priceTypes = "price-types"
    case taxBases = "tax-bases"

    public var description: String {
        return rawValue
    }
}
