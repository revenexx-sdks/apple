import Foundation

public enum SegmentRulePreviewRequestRuleMatch: String, CustomStringConvertible {
    case all = "all"
    case any = "any"

    public var description: String {
        return rawValue
    }
}
