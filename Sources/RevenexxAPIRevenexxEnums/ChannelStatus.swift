import Foundation

public enum ChannelStatus: String, CustomStringConvertible {
    case active = "active"
    case inactive = "inactive"

    public var description: String {
        return rawValue
    }
}
