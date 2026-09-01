import Foundation

public enum SegmentRuleOperator: String, CustomStringConvertible {
    case eq = "eq"
    case neq = "neq"
    case gt = "gt"
    case gte = "gte"
    case lt = "lt"
    case lte = "lte"
    case `in` = "in"
    case contains = "contains"
    case startsWith = "starts_with"
    case endsWith = "ends_with"
    case isEmpty = "is_empty"
    case isNotEmpty = "is_not_empty"

    public var description: String {
        return rawValue
    }
}
