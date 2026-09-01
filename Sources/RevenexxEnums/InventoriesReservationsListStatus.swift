import Foundation

public enum InventoriesReservationsListStatus: String, CustomStringConvertible {
    case active = "active"
    case released = "released"
    case committed = "committed"

    public var description: String {
        return rawValue
    }
}
