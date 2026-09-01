import Foundation

public enum ContactEventKindTone: String, CustomStringConvertible {
    case neutral = "neutral"
    case info = "info"
    case success = "success"
    case warning = "warning"
    case danger = "danger"

    public var description: String {
        return rawValue
    }
}
