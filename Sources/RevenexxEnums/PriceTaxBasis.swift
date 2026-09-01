import Foundation

public enum PriceTaxBasis: String, CustomStringConvertible {
    case net = "net"
    case gross = "gross"

    public var description: String {
        return rawValue
    }
}
