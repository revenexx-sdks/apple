import Foundation

public enum StoreAssetRequestVisibility: String, CustomStringConvertible {
    case `public` = "public"
    case `private` = "private"

    public var description: String {
        return rawValue
    }
}
