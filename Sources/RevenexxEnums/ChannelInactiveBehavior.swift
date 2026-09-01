import Foundation

public enum ChannelInactiveBehavior: String, CustomStringConvertible {
    case serve = "serve"
    case block = "block"

    public var description: String {
        return rawValue
    }
}
