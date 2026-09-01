import Foundation

public enum PriceRoundingMode: String, CustomStringConvertible {
    case halfUp = "half_up"
    case halfEven = "half_even"
    case up = "up"
    case down = "down"

    public var description: String {
        return rawValue
    }
}
