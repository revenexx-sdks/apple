import Foundation
import JSONCodable
import RevenexxEnums

/// Counts, not rows: an import chunk of 5000 does not echo 5000 entries back.
open class PriceEntriesBulkResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case created = "created"
        case mode = "mode"
        case updated = "updated"
    }

    /// Rows inserted — rungs this list did not have.
    public let created: Int?
    /// The mode actually applied — the request's, or the default `upsert`.
    public let mode: RevenexxEnums.PriceEntriesBulkMode?
    /// Existing rungs rewritten in place (always 0 in append mode).
    public let updated: Int?

    init(
        created: Int?,
        mode: RevenexxEnums.PriceEntriesBulkMode?,
        updated: Int?
    ) {
        self.created = created
        self.mode = mode
        self.updated = updated
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created = try container.decodeIfPresent(Int.self, forKey: .created)
        if let modeString = try container.decodeIfPresent(String.self, forKey: .mode) {
            self.mode = RevenexxEnums.PriceEntriesBulkMode(rawValue: modeString)
        } else {
            self.mode = nil
        }
        self.updated = try container.decodeIfPresent(Int.self, forKey: .updated)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(mode?.rawValue, forKey: .mode)
        try container.encodeIfPresent(updated, forKey: .updated)
    }

    public func toMap() -> [String: Any] {
        return [
            "created": created as Any,
            "mode": mode?.rawValue as Any,
            "updated": updated as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesBulkResponse {
        return PriceEntriesBulkResponse(
            created: map["created"] as? Int,
            mode: map["mode"] as? String != nil ? PriceEntriesBulkMode(rawValue: map["mode"] as! String) : nil,
            updated: map["updated"] as? Int
        )
    }
}
