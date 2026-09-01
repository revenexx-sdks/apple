import Foundation

public enum AuthMailSource: String, CustomStringConvertible {
    case tenant = "tenant"
    case platform = "platform"

    public var description: String {
        return rawValue
    }
}
