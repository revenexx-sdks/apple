import Foundation

public enum OrderReturnRefusal: String, CustomStringConvertible {
    case wearAndTear = "wear_and_tear"
    case notReturnable = "not_returnable"

    public var description: String {
        return rawValue
    }
}
