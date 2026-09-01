import Foundation

public enum ChannelContextSource: String, CustomStringConvertible {
    case body = "body"
    case query = "query"
    case header = "header"
    case jwt = "jwt"
    case `default` = "default"

    public var description: String {
        return rawValue
    }
}
