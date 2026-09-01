import Foundation

public enum PriceTaxBasisSource: String, CustomStringConvertible {
    case list = "list"
    case listLegacy = "list_legacy"
    case tenant = "tenant"

    public var description: String {
        return rawValue
    }
}
