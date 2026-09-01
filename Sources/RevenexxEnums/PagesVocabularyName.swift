import Foundation

public enum PagesVocabularyName: String, CustomStringConvertible {
    case editStateStatuses = "edit-state-statuses"
    case pageStatuses = "page-statuses"
    case translationStatuses = "translation-statuses"

    public var description: String {
        return rawValue
    }
}
