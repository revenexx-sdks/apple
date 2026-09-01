import Foundation

public enum ChannelsVocabulariesGetName: String, CustomStringConvertible {
    case statuses = "statuses"
    case types = "types"
    case unassignedVisibility = "unassigned-visibility"

    public var description: String {
        return rawValue
    }
}
