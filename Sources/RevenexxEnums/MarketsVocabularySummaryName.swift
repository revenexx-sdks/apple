import Foundation

public enum MarketsVocabularySummaryName: String, CustomStringConvertible {
    case marketStatuses = "market-statuses"

    public var description: String {
        return rawValue
    }
}
