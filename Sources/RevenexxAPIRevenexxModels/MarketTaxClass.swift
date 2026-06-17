import Foundation
import JSONCodable

/// 
open class MarketTaxClass: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case market_id = "market_id"
        case name = "name"
        case position = "position"
        case rate = "rate"
        case updated_at = "updated_at"
    }

    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let is_default: Bool?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let market_id: String?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let rate: Double?
    /// 
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        market_id: String?,
        name: String?,
        position: Int?,
        rate: Double?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.market_id = market_id
        self.name = name
        self.position = position
        self.rate = rate
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "market_id": market_id as Any,
            "name": name as Any,
            "position": position as Any,
            "rate": rate as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketTaxClass {
        return MarketTaxClass(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            market_id: map["market_id"] as? String,
            name: map["name"] as? String,
            position: map["position"] as? Int,
            rate: map["rate"] as? Double,
            updated_at: map["updated_at"] as? String
        )
    }
}
