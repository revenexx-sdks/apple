import Foundation

public enum Kind: String, CustomStringConvertible {
    case simple = "simple"
    case model = "model"
    case variant = "variant"

    public var description: String {
        return rawValue
    }
}
