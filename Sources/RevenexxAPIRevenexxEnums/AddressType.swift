import Foundation

public enum AddressType: String, CustomStringConvertible {
    case billing = "billing"
    case shipping = "shipping"

    public var description: String {
        return rawValue
    }
}
