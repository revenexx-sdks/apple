import Foundation

public enum ChannelPolicySource: String, CustomStringConvertible {
    case tenant = "tenant"
    case channel = "channel"

    public var description: String {
        return rawValue
    }
}
