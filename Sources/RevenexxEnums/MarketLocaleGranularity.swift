import Foundation

public enum MarketLocaleGranularity: String, CustomStringConvertible {
    case regional = "regional"
    case language = "language"

    public var description: String {
        return rawValue
    }
}
