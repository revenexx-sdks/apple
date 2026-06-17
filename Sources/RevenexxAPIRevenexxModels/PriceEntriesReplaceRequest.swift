import Foundation
import JSONCodable

/// 
open class PriceEntriesReplaceRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case entries = "entries"
    }

    /// The complete new entry set (set semantics).
    public let entries: [PriceEntryReplaceItem]

    init(
        entries: [PriceEntryReplaceItem]
    ) {
        self.entries = entries
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.entries = try container.decode([PriceEntryReplaceItem].self, forKey: .entries)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(entries, forKey: .entries)
    }

    public func toMap() -> [String: Any] {
        return [
            "entries": entries.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesReplaceRequest {
        return PriceEntriesReplaceRequest(
            entries: (map["entries"] as! [[String: Any]]).map { PriceEntryReplaceItem.from(map: $0) }
        )
    }
}
