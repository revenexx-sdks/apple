import Foundation

public enum ShippingVocabulariesGetName: String, CustomStringConvertible {
    case carrierStatuses = "carrier-statuses"
    case matrixBases = "matrix-bases"
    case pricingTypes = "pricing-types"
    case serviceLevels = "service-levels"
    case weightUnits = "weight-units"

    public var description: String {
        return rawValue
    }
}
