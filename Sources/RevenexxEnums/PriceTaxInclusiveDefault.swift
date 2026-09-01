import Foundation

public enum PriceTaxInclusiveDefault: String, CustomStringConvertible {
    case net = "net"
    case gross = "gross"

    public var description: String {
        return rawValue
    }
}
