import Foundation

public enum PriceEntryType: String, CustomStringConvertible {
    case standard = "standard"
    case onRequest = "on_request"

    public var description: String {
        return rawValue
    }
}
