import Foundation
import JSONCodable

/// Every comment of the page, roots and replies flat in one list, oldest first — the editor builds the threads from `parentUuid`. Every write route answers this same full list rather than the row it changed.
open class PageCommentList: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    /// The page's comments, oldest first.
    public let items: [PageCommentItem]?

    init(
        items: [PageCommentItem]?
    ) {
        self.items = items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([PageCommentItem].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCommentList {
        return PageCommentList(
            items: (map["items"] as? [[String: Any]] ?? []).map { PageCommentItem.from(map: $0) }
        )
    }
}
