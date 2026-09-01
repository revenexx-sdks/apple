import Foundation

public enum InventoriesVocabulariesGetName: String, CustomStringConvertible {
    case locationTypes = "location-types"
    case movementTypes = "movement-types"
    case reservationStatuses = "reservation-statuses"

    public var description: String {
        return rawValue
    }
}
