import Foundation

public enum PriceListTaxBasis: String, CustomStringConvertible {
    case net = "net"
    case gross = "gross"

    public var description: String {
        return rawValue
    }
}
