import Foundation
import JSONCodable

/// 
open class ProductLabelsRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case ids = "ids"
        case skus = "skus"
    }

    /// Product ids to name. At most 500.
    public let ids: [String]?
    /// Product SKUs to name. At most 500.
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

    public static func from(map: [String: Any] ) -> ProductLabelsRequest {
        return ProductLabelsRequest(
            ids: map["ids"] as? [String],
            skus: map["skus"] as? [String]
        )
    }
}
