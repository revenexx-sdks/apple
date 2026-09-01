import Foundation

public enum MarketTaxBasis: String, CustomStringConvertible {
    case net = "net"
    case gross = "gross"

    public var description: String {
        return rawValue
    }
}
