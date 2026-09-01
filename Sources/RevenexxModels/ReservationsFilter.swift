import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `reservations` — a typo, a filter another entity has, `?q=` — is DROPPED and cannot appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class ReservationsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case expires_at = "expires_at"
        case id = "id"
        case location_id = "location_id"
        case metadata = "metadata"
        case order_ref = "order_ref"
        case product_id = "product_id"
        case quantity = "quantity"
        case sku = "sku"
        case status = "status"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?expires_at=` value this call was understood to carry.
    public let expires_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?location_id=` value this call was understood to carry.
    public let location_id: String?
    /// The literal `?metadata=` value this call was understood to carry.
    public let metadata: String?
    /// The literal `?order_ref=` value this call was understood to carry.
    public let order_ref: String?
    /// The literal `?product_id=` value this call was understood to carry.
    public let product_id: String?
    /// The literal `?quantity=` value this call was understood to carry.
    public let quantity: String?
    /// The literal `?sku=` value this call was understood to carry.
    public let sku: String?
    /// The literal `?status=` value this call was understood to carry.
    public let status: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        created_at: String?,
        expires_at: String?,
        id: String?,
        location_id: String?,
        metadata: String?,
        order_ref: String?,
        product_id: String?,
        quantity: String?,
        sku: String?,
        status: String?,
        updated_at: String?,
        data: T
    ) {
        self.created_at = created_at
        self.expires_at = expires_at
        self.id = id
        self.location_id = location_id
        self.metadata = metadata
        self.order_ref = order_ref
        self.product_id = product_id
        self.quantity = quantity
        self.sku = sku
        self.status = status
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.location_id = try container.decodeIfPresent(String.self, forKey: .location_id)
        self.metadata = try container.decodeIfPresent(String.self, forKey: .metadata)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.product_id = try container.decodeIfPresent(String.self, forKey: .product_id)
        self.quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
        self.sku = try container.decodeIfPresent(String.self, forKey: .sku)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(expires_at, forKey: .expires_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(location_id, forKey: .location_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(product_id, forKey: .product_id)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(sku, forKey: .sku)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "expires_at": expires_at as Any,
            "id": id as Any,
            "location_id": location_id as Any,
            "metadata": metadata as Any,
            "order_ref": order_ref as Any,
            "product_id": product_id as Any,
            "quantity": quantity as Any,
            "sku": sku as Any,
            "status": status as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> ReservationsFilter {
        return ReservationsFilter(
            created_at: map["created_at"] as? String,
            expires_at: map["expires_at"] as? String,
            id: map["id"] as? String,
            location_id: map["location_id"] as? String,
            metadata: map["metadata"] as? String,
            order_ref: map["order_ref"] as? String,
            product_id: map["product_id"] as? String,
            quantity: map["quantity"] as? String,
            sku: map["sku"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
