import Foundation

public enum CartMergeStrategy: String, CustomStringConvertible {
    case merge = "merge"
    case replace = "replace"

    public var description: String {
        return rawValue
    }
}
