import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `product_associations` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class ProductAssociationsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case association_type_id = "association_type_id"
        case created_at = "created_at"
        case id = "id"
        case position = "position"
        case product_id = "product_id"
        case quantity = "quantity"
        case target_product_id = "target_product_id"
        case data
    }

    /// The literal `?association_type_id=` value this call was understood to carry.
    public let association_type_id: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?product_id=` value this call was understood to carry.
    public let product_id: String?
    /// The literal `?quantity=` value this call was understood to carry.
    public let quantity: String?
    /// The literal `?target_product_id=` value this call was understood to carry.
    public let target_product_id: String?
    /// Additional properties
    public let data: T

    init(
        association_type_id: String?,
        created_at: String?,
        id: String?,
        position: String?,
        product_id: String?,
        quantity: String?,
        target_product_id: String?,
        data: T
    ) {
        self.association_type_id = association_type_id
        self.created_at = created_at
        self.id = id
        self.position = position
        self.product_id = product_id
        self.quantity = quantity
        self.target_product_id = target_product_id
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.association_type_id = try container.decodeIfPresent(String.self, forKey: .association_type_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
        self.target_product_id = try container.decodeIfPresent(String.self, forKey: .target_product_id)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(association_type_id, forKey: .association_type_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(target_product_id, forKey: .target_product_id)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "association_type_id": association_type_id as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "target_product_id": target_product_id as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> ProductAssociationsFilter {
        return ProductAssociationsFilter(
            association_type_id: map["association_type_id"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            position: map["position"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? String,
            target_product_id: map["target_product_id"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
