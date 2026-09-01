import Foundation

public enum CreateImportTarget: String, CustomStringConvertible {
    case live = "live"
    case shadow = "shadow"

    public var description: String {
        return rawValue
    }
}
