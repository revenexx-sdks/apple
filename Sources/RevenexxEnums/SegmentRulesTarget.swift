import Foundation

public enum SegmentRulesTarget: String, CustomStringConvertible {
    case organizations = "organizations"

    public var description: String {
        return rawValue
    }
}
