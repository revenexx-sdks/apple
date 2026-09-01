import Foundation

public enum SegmentMemberSource: String, CustomStringConvertible {
    case manual = "manual"
    case rule = "rule"

    public var description: String {
        return rawValue
    }
}
