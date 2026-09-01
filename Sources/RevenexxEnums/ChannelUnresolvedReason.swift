import Foundation

public enum ChannelUnresolvedReason: String, CustomStringConvertible {
    case channelRequired = "channel_required"
    case noDefaultChannel = "no_default_channel"
    case unknownChannel = "unknown_channel"
    case channelInactive = "channel_inactive"

    public var description: String {
        return rawValue
    }
}
