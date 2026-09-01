import Foundation

public enum ValidationFailedResponseStatus: String, CustomStringConvertible {
    case invalid = "invalid"

    public var description: String {
        return rawValue
    }
}
