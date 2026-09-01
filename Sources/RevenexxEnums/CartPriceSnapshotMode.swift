import Foundation

public enum CartPriceSnapshotMode: String, CustomStringConvertible {
    case snapshot = "snapshot"
    case live = "live"

    public var description: String {
        return rawValue
    }
}
