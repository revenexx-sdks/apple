import Foundation

public enum EntityType: String, CustomStringConvertible {
    case product = "product"
    case referenceEntity = "reference_entity"
    case asset = "asset"
    case category = "category"

    public var description: String {
        return rawValue
    }
}
