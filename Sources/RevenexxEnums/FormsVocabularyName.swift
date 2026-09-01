import Foundation

public enum FormsVocabularyName: String, CustomStringConvertible {
    case formStatuses = "form-statuses"
    case submissionStatuses = "submission-statuses"

    public var description: String {
        return rawValue
    }
}
