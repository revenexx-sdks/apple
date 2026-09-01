import Foundation

public enum PriceListTiebreak: String, CustomStringConvertible {
    case lowestPrice = "lowest_price"
    case highestPrice = "highest_price"
    case newest = "newest"
    case code = "code"

    public var description: String {
        return rawValue
    }
}
