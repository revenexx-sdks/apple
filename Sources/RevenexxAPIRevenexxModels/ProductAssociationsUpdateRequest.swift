import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class ProductAssociationsUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case association_type_id = "association_type_id"
        case position = "position"
        case product_id = "product_id"
        case quantity = "quantity"
        case target_product_id = "target_product_id"
    }

    /// 
    public let association_type_id: String?
    /// 
    public let position: Int?
    /// 
    public let product_id: String?
    /// 
    public let quantity: Double?
    /// 
    public let target_product_id: String?

    init(
        association_type_id: String?,
        position: Int?,
        product_id: String?,
        quantity: Double?,
        target_product_id: String?
    ) {
        self.association_type_id = association_type_id
        self.position = position
        self.product_id = product_id
        self.quantity = quantity
        self.target_product_id = target_product_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.association_type_id = try container.decodeIfPresent(String.self, forKey: .association_type_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.target_product_id = try container.decodeIfPresent(String.self, forKey: .target_product_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(association_type_id, forKey: .association_type_id)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(target_product_id, forKey: .target_product_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "association_type_id": association_type_id as Any,
            "position": position as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "target_product_id": target_product_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductAssociationsUpdateRequest {
        return ProductAssociationsUpdateRequest(
            association_type_id: map["association_type_id"] as? String,
            position: map["position"] as? Int,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? Double,
            target_product_id: map["target_product_id"] as? String
        )
    }
}
