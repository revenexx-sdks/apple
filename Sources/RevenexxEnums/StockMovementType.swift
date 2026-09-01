import Foundation

public enum StockMovementType: String, CustomStringConvertible {
    case inbound = "inbound"
    case adjustment = "adjustment"
    case reserve = "reserve"
    case release = "release"
    case shipment = "shipment"
    case restock = "restock"

    public var description: String {
        return rawValue
    }
}
