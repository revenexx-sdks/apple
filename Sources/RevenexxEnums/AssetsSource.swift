import Foundation

public enum AssetsSource: String, CustomStringConvertible {
    case storage = "storage"
    case external = "external"

    public var description: String {
        return rawValue
    }
}
