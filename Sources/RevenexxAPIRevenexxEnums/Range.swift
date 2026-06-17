import Foundation

public enum Range: String, CustomStringConvertible {
    case 24h = "24h"
    case 30d = "30d"
    case 90d = "90d"

    public var description: String {
        return rawValue
    }
}
