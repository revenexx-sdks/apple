import Foundation

public enum OrderResolutionStage: String, CustomStringConvertible {
    case complete = "complete"
    case reject = "reject"

    public var description: String {
        return rawValue
    }
}
