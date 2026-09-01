import Foundation

public enum Range: String, CustomStringConvertible {
    case _24h = "24h"
    case _30d = "30d"
    case _90d = "90d"

    public var description: String {
        return rawValue
    }
}
