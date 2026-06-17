import Foundation

public enum CartIoApplyMode: String, CustomStringConvertible {
    case insert = "insert"
    case append = "append"
    case replace = "replace"

    public var description: String {
        return rawValue
    }
}
