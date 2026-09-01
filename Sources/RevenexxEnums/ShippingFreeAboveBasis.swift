import Foundation

public enum ShippingFreeAboveBasis: String, CustomStringConvertible {
    case net = "net"
    case gross = "gross"

    public var description: String {
        return rawValue
    }
}
