import Foundation

public enum WhatsappCategory: String, CustomStringConvertible {
    case marketing = "marketing"
    case utility = "utility"
    case authentication = "authentication"
    case service = "service"

    public var description: String {
        return rawValue
    }
}
