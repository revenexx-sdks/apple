import Foundation

public enum MarketReadinessSeverity: String, CustomStringConvertible {
    case blocking = "blocking"
    case warning = "warning"
    case info = "info"

    public var description: String {
        return rawValue
    }
}
