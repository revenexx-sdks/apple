import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class ReferenceEntitiesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image = "image"
        case labels = "labels"
    }

    /// The entity's stable identifier — a domain of records the catalog POINTS AT instead of duplicating, so a brand is edited once and not on nine thousand products. Unique per tenant.
    public let code: String?
    /// A delivery path or URL for the entity's own icon. Cosmetic — nothing in this app resolves it.
    public let image: String?
    /// What the entity is called, per language tag — the heading over its record list.
    public let labels: [String: AnyCodable]?

    init(
        code: String?,
        image: String?,
        labels: [String: AnyCodable]?
    ) {
        self.code = code
        self.image = image
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "image": image as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntitiesUpdateRequest {
        return ReferenceEntitiesUpdateRequest(
            code: map["code"] as? String,
            image: map["image"] as? String,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
