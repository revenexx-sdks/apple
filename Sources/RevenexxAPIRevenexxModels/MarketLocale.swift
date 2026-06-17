import Foundation
import JSONCodable

/// 
open class MarketLocale: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "country"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case language = "language"
        case market_id = "market_id"
        case position = "position"
    }

    /// 
    public let code: String?
    /// 
    public let country: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let is_default: Bool?
    /// 
    public let language: String?
    /// 
    public let market_id: String?
    /// 
    public let position: Int?

    init(
        code: String?,
        country: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        language: String?,
        market_id: String?,
        position: Int?
    ) {
        self.code = code
        self.country = country
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.language = language
        self.market_id = market_id
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "country": country as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "language": language as Any,
            "market_id": market_id as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocale {
        return MarketLocale(
            code: map["code"] as? String,
            country: map["country"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            language: map["language"] as? String,
            market_id: map["market_id"] as? String,
            position: map["position"] as? Int
        )
    }
}
