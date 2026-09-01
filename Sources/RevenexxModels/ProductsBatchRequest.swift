import Foundation
import JSONCodable

/// Name the products either way, or both ways. Send at least one non-empty list; the two are unioned and a product named twice comes back once.
open class ProductsBatchRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case ids = "ids"
        case skus = "skus"
    }

    /// Product ids, when the caller already holds them.
    public let ids: [String]?
    /// Product SKUs — the identifier a foreign system carries, which is why this route exists at all.
    public let skus: [String]?

    init(
        ids: [String]?,
        skus: [String]?
    ) {
        self.ids = ids
        self.skus = skus
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.ids = try container.decodeIfPresent([String].self, forKey: .ids)
        self.skus = try container.decodeIfPresent([String].self, forKey: .skus)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(ids, forKey: .ids)
        try container.encodeIfPresent(skus, forKey: .skus)
    }

    public func toMap() -> [String: Any] {
        return [
            "ids": ids as Any,
            "skus": skus as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductsBatchRequest {
        return ProductsBatchRequest(
            ids: map["ids"] as? [String],
            skus: map["skus"] as? [String]
        )
    }
}
