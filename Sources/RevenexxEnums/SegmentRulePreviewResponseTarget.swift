import Foundation

public enum SegmentRulePreviewResponseTarget: String, CustomStringConvertible {
    case organizations = "organizations"

    public var description: String {
        return rawValue
    }
}
