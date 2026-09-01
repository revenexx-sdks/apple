import Foundation

public enum OrderListCartMode: String, CustomStringConvertible {
    case append = "append"
    case replace = "replace"

    public var description: String {
        return rawValue
    }
}
