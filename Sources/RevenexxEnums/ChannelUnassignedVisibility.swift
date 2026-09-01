import Foundation

public enum ChannelUnassignedVisibility: String, CustomStringConvertible {
    case inherit = "inherit"
    case all = "all"
    case assignedOnly = "assigned_only"

    public var description: String {
        return rawValue
    }
}
