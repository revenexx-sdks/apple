import Foundation

public enum Name: String, CustomStringConvertible {
    case ioApplyModes = "io-apply-modes"
    case ioDirections = "io-directions"
    case ioEntities = "io-entities"
    case ioFormats = "io-formats"
    case itemTypes = "item-types"
    case statuses = "statuses"

    public var description: String {
        return rawValue
    }
}
