import Foundation

public enum RecoveryMailSource: String, CustomStringConvertible {
    case tenant = "tenant"
    case platform = "platform"

    public var description: String {
        return rawValue
    }
}
