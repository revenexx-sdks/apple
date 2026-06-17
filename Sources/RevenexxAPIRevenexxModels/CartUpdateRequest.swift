import Foundation
import JSONCodable

/// Only safe columns are updatable — status moves through the lifecycle routes.
open class CartUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case currency = "currency"
        case market_id = "market_id"
        case metadata = "metadata"
        case name = "name"
    }

    /// 
    public let channel_id: String?
    /// ISO 4217 code.
    public let currency: String?
    /// 
    public let market_id: String?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?

    init(
        channel_id: String?,
        currency: String?,
        market_id: String?,
        metadata: [String: AnyCodable]?,
        name: String?
    ) {
        self.channel_id = channel_id
        self.currency = currency
        self.market_id = market_id
        self.metadata = metadata
        self.name = name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "currency": currency as Any,
            "market_id": market_id as Any,
            "metadata": metadata as Any,
            "name": name as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartUpdateRequest {
        return CartUpdateRequest(
            channel_id: map["channel_id"] as? String,
            currency: map["currency"] as? String,
            market_id: map["market_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String
        )
    }
}
