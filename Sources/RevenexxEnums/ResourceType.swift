import Foundation

public enum ResourceType: String, CustomStringConvertible {
    case template = "template"
    case layout = "layout"
    case suppression = "suppression"

    public var description: String {
        return rawValue
    }
}
