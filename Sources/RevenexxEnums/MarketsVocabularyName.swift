import Foundation

public enum MarketsVocabularyName: String, CustomStringConvertible {
    case marketStatuses = "market-statuses"

    public var description: String {
        return rawValue
    }
}
