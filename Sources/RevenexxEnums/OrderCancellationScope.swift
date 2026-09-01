import Foundation

public enum OrderCancellationScope: String, CustomStringConvertible {
    case order = "order"
    case items = "items"

    public var description: String {
        return rawValue
    }
}
