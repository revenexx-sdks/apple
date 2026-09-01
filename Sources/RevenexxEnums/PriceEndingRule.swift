import Foundation

public enum PriceEndingRule: String, CustomStringConvertible {
    case exact = "exact"
    case whole = "whole"
    case ending99 = "ending_99"
    case ending95 = "ending_95"
    case ending50 = "ending_50"

    public var description: String {
        return rawValue
    }
}
