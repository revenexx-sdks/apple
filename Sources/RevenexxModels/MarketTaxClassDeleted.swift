import Foundation
import JSONCodable

/// Confirmation that the tax class of a market is gone. The row itself is not returned — read it before deleting if you need it.
open class MarketTaxClassDeleted: Codable {

    enum CodingKeys: String, CodingKey {
        case deleted = "deleted"
        case id = "id"
        case usage_checked = "usage_checked"
    }

    /// Always true — a row that was not there is a 404, not a false.
    public let deleted: Bool?
    /// The id of the row that was deleted.
    public let id: String?
    /// False when the cross-app usage question could not be asked (shipping not installed, or unreachable) — the row was deleted without that guarantee.
    public let usage_checked: Bool?

    init(
        deleted: Bool?,
        id: String?,
        usage_checked: Bool?
    ) {
        self.deleted = deleted
        self.id = id
        self.usage_checked = usage_checked
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.usage_checked = try container.decodeIfPresent(Bool.self, forKey: .usage_checked)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(usage_checked, forKey: .usage_checked)
    }

    public func toMap() -> [String: Any] {
        return [
            "deleted": deleted as Any,
            "id": id as Any,
            "usage_checked": usage_checked as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketTaxClassDeleted {
        return MarketTaxClassDeleted(
            deleted: map["deleted"] as? Bool,
            id: map["id"] as? String,
            usage_checked: map["usage_checked"] as? Bool
        )
    }
}
