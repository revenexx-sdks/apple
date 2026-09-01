import Foundation

public enum ChannelVocabularyName: String, CustomStringConvertible {
    case statuses = "statuses"
    case types = "types"
    case unassignedVisibility = "unassigned-visibility"

    public var description: String {
        return rawValue
    }
}
