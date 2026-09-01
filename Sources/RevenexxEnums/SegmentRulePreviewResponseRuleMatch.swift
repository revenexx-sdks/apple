import Foundation

public enum SegmentRulePreviewResponseRuleMatch: String, CustomStringConvertible {
    case all = "all"
    case any = "any"

    public var description: String {
        return rawValue
    }
}
