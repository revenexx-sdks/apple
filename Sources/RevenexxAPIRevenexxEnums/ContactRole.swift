import Foundation

public enum ContactRole: String, CustomStringConvertible {
    case buyer = "buyer"
    case approver = "approver"
    case admin = "admin"
    case requester = "requester"

    public var description: String {
        return rawValue
    }
}
