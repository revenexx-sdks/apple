import Foundation

public enum PaymentMethodKind: String, CustomStringConvertible {
    case selfManaged = "self_managed"
    case psp = "psp"

    public var description: String {
        return rawValue
    }
}
