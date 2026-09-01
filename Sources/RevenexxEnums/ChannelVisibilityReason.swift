import Foundation

public enum ChannelVisibilityReason: String, CustomStringConvertible {
    case assigned = "assigned"
    case notAssignedToChannel = "not_assigned_to_channel"
    case unassignedOpen = "unassigned_open"
    case unassignedClosed = "unassigned_closed"
    case noChannelContext = "no_channel_context"

    public var description: String {
        return rawValue
    }
}
