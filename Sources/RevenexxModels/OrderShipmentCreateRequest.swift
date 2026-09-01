import Foundation
import JSONCodable

/// Book what went out. Every field is optional: an empty body ships every position that still has an open quantity, in full, on a delivery note number drawn from the tenant's delivery range — which is the whole payload for the common case.
open class OrderShipmentCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case metadata = "metadata"
        case number = "number"
        case positions = "positions"
        case shipped_at = "shipped_at"
        case tracking_code = "tracking_code"
        case tracking_url = "tracking_url"
    }

    /// Who is carrying it, in the merchant's own words. Free text — this app neither validates it nor knows the carrier's API.
    public let carrier: String?
    /// Free-form data for the caller — the warehouse system's own reference for this handover. Stored and returned untouched.
    public let metadata: [String: AnyCodable]?
    /// The DELIVERY NOTE number — drawn from the tenant's delivery range, unique per tenant, and a different series from the order number. A caller may supply its own when the number is issued by the warehouse system instead. Drawn from the 'delivery' range when omitted; supply one only when the number is issued elsewhere.
    public let number: String?
    /// What this shipment carries. Omitted = every position with an open quantity, in full. GET /orders/{id}/shippable answers exactly the budget each one is guarded against.
    public let positions: [OrderShipmentPosition]?
    /// When the goods actually left. Defaults to now, and a caller may backdate it — a shipment booked on Monday for a Friday handover says Friday.
    public let shipped_at: String?
    /// The consignment number the carrier issued. Free text: every carrier formats it differently and this app stores whatever it is given.
    public let tracking_code: String?
    /// Where a human can follow the parcel. Supplied by the caller — this app does not build it, because only the caller knows the carrier's tracking address.
    public let tracking_url: String?

    init(
        carrier: String?,
        metadata: [String: AnyCodable]?,
        number: String?,
        positions: [OrderShipmentPosition]?,
        shipped_at: String?,
        tracking_code: String?,
        tracking_url: String?
    ) {
        self.carrier = carrier
        self.metadata = metadata
        self.number = number
        self.positions = positions
        self.shipped_at = shipped_at
        self.tracking_code = tracking_code
        self.tracking_url = tracking_url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.positions = try container.decodeIfPresent([OrderShipmentPosition].self, forKey: .positions)
        self.shipped_at = try container.decodeIfPresent(String.self, forKey: .shipped_at)
        self.tracking_code = try container.decodeIfPresent(String.self, forKey: .tracking_code)
        self.tracking_url = try container.decodeIfPresent(String.self, forKey: .tracking_url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(shipped_at, forKey: .shipped_at)
        try container.encodeIfPresent(tracking_code, forKey: .tracking_code)
        try container.encodeIfPresent(tracking_url, forKey: .tracking_url)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "positions": positions?.map { $0.toMap() } as Any,
            "shipped_at": shipped_at as Any,
            "tracking_code": tracking_code as Any,
            "tracking_url": tracking_url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderShipmentCreateRequest {
        return OrderShipmentCreateRequest(
            carrier: map["carrier"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            positions: (map["positions"] as? [[String: Any]] ?? []).map { OrderShipmentPosition.from(map: $0) },
            shipped_at: map["shipped_at"] as? String,
            tracking_code: map["tracking_code"] as? String,
            tracking_url: map["tracking_url"] as? String
        )
    }
}
