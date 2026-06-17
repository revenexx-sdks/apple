import Foundation

public enum ChannelType: String, CustomStringConvertible {
    case storefront = "storefront"
    case punchout = "punchout"
    case marketplace = "marketplace"
    case api = "api"
    case pos = "pos"

    public var description: String {
        return rawValue
    }
}
