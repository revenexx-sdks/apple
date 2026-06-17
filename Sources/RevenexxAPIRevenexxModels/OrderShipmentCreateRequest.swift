import Foundation
import JSONCodable

/// Create a shipment. Omitted positions = ship everything still open.
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

    /// 
    public let carrier: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Delivery note number — drawn from the &#039;delivery&#039; range when omitted.
    public let number: String?
    /// Omitted = every position with open quantity, in full.
    public let positions: [OrderShipmentPosition]?
    /// Defaults to now.
    public let shipped_at: String?
    /// 
    public let tracking_code: String?
    /// 
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
            "positions": positions.map { $0.toMap() } as Any,
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
