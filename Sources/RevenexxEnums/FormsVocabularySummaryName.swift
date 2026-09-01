import Foundation

public enum FormsVocabularySummaryName: String, CustomStringConvertible {
    case formStatuses = "form-statuses"
    case submissionStatuses = "submission-statuses"

    public var description: String {
        return rawValue
    }
}
