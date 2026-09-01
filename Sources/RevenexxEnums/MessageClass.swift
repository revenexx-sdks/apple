import Foundation

public enum MessageClass: String, CustomStringConvertible {
    case transactional = "transactional"
    case marketing = "marketing"

    public var description: String {
        return rawValue
    }
}
