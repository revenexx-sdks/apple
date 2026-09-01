import Foundation

public enum InventoriesLocationsListType: String, CustomStringConvertible {
    case warehouse = "warehouse"
    case store = "store"
    case dropship = "dropship"
    case virtual = "virtual"

    public var description: String {
        return rawValue
    }
}
