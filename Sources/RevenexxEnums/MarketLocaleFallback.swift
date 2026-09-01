import Foundation

public enum MarketLocaleFallback: String, CustomStringConvertible {
    case language = "language"
    case defaultLocale = "default_locale"
    case `none` = "none"

    public var description: String {
        return rawValue
    }
}
