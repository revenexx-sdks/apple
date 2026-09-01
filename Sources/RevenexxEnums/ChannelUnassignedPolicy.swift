import Foundation

public enum ChannelUnassignedPolicy: String, CustomStringConvertible {
    case all = "all"
    case assignedOnly = "assigned_only"

    public var description: String {
        return rawValue
    }
}
