import Foundation

public enum ChannelPolicyTenantDefault: String, CustomStringConvertible {
    case all = "all"
    case assignedOnly = "assigned_only"

    public var description: String {
        return rawValue
    }
}
