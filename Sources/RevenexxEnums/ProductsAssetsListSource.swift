import Foundation

public enum ProductsAssetsListSource: String, CustomStringConvertible {
    case storage = "storage"
    case external = "external"

    public var description: String {
        return rawValue
    }
}
