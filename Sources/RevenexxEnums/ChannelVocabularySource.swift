import Foundation

public enum ChannelVocabularySource: String, CustomStringConvertible {
    case schema = "schema"
    case table = "table"

    public var description: String {
        return rawValue
    }
}
