import Foundation

public enum ProductLabelAttributeSource: String, CustomStringConvertible {
    case family = "family"
    case setting = "setting"
    case convention = "convention"

    public var description: String {
        return rawValue
    }
}
