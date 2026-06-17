import Foundation

public enum Visibility: String, CustomStringConvertible {
    case `public` = "public"
    case `private` = "private"

    public var description: String {
        return rawValue
    }
}
