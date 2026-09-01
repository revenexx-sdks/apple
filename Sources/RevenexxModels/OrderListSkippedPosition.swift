import Foundation
import JSONCodable

/// A position left out of the conversion because the catalogue no longer knows its article (only ever non-empty when the tenant's 'on_missing_article' setting is 'skip').
open class OrderListSkippedPosition: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case product_id = "product_id"
        case sku = "sku"
    }

    /// The position that was left out, so a client can point at the row in the list.
    public let id: String?
    /// The saved article name, so the omission can be reported to the buyer in words they recognise.
    public let name: String?
    /// The catalogue product the position named, if it named one.
    public let product_id: String?
    /// The article number the position named, if it named one.
    public let sku: String?

    init(
        id: String?,
        name: String?,
        product_id: String?,
        sku: String?
    ) {
        self.id = id
        self.name = name
        self.product_id = product_id
        self.sku = sku
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(sku, forKey: .sku)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "name": name as Any,
            "product_id": product_id as Any,
            "sku": sku as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListSkippedPosition {
        return OrderListSkippedPosition(
            id: map["id"] as? String,
            name: map["name"] as? String,
            product_id: map["product_id"] as? String,
            sku: map["sku"] as? String
        )
    }
}
