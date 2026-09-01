import Foundation

public enum SegmentRulePreviewRequestTarget: String, CustomStringConvertible {
    case organizations = "organizations"

    public var description: String {
        return rawValue
    }
}
