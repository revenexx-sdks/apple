import Foundation
import JSONCodable

/// Where to put the undo pointer.
open class PageHistoryRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case index = "index"
        case langcode = "langcode"
    }

    /// The position in the mutation log to materialize at. `-1` undoes everything; the last position redoes everything. Values outside the log are clamped rather than refused.
    public let index: Int
    /// Which language the returned state should be resolved for.
    public let langcode: String?

    init(
        index: Int,
        langcode: String?
    ) {
        self.index = index
        self.langcode = langcode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.index = try container.decode(Int.self, forKey: .index)
        self.langcode = try container.decodeIfPresent(String.self, forKey: .langcode)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(index, forKey: .index)
        try container.encodeIfPresent(langcode, forKey: .langcode)
    }

    public func toMap() -> [String: Any] {
        return [
            "index": index as Any,
            "langcode": langcode as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageHistoryRequest {
        return PageHistoryRequest(
            index: map["index"] as! Int,
            langcode: map["langcode"] as? String
        )
    }
}
