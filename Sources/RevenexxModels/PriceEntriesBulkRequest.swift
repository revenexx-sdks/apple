import Foundation
import JSONCodable
import RevenexxEnums

/// A chunk of an import. Unlike the replace call it never wipes the list.
open class PriceEntriesBulkRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case entries = "entries"
        case mode = "mode"
    }

    /// At most 5000 rows per call — send a large book in chunks.
    public let entries: [PriceEntryReplaceItem]
    /// Default 'upsert': a row naming a rung the list already has (same product/sku AND quantity_min) updates it. 'append' always inserts — a re-run then duplicates the ladder, which is what makes an ambiguous tier table.
    public let mode: RevenexxEnums.PriceEntriesBulkMode?

    init(
        entries: [PriceEntryReplaceItem],
        mode: RevenexxEnums.PriceEntriesBulkMode?
    ) {
        self.entries = entries
        self.mode = mode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.entries = try container.decode([PriceEntryReplaceItem].self, forKey: .entries)
        if let modeString = try container.decodeIfPresent(String.self, forKey: .mode) {
            self.mode = RevenexxEnums.PriceEntriesBulkMode(rawValue: modeString)
        } else {
            self.mode = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(entries, forKey: .entries)
        try container.encodeIfPresent(mode?.rawValue, forKey: .mode)
    }

    public func toMap() -> [String: Any] {
        return [
            "entries": entries.map { $0.toMap() } as Any,
            "mode": mode?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesBulkRequest {
        return PriceEntriesBulkRequest(
            entries: (map["entries"] as! [[String: Any]]).map { PriceEntryReplaceItem.from(map: $0) },
            mode: map["mode"] as? String != nil ? PriceEntriesBulkMode(rawValue: map["mode"] as! String) : nil
        )
    }
}
