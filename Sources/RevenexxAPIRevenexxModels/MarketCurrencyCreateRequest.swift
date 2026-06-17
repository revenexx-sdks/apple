import Foundation
import JSONCodable

/// The owning market comes from the route path (&#039;market_id&#039;).
open class MarketCurrencyCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case position = "position"
    }

    /// ISO 4217 code, e.g. EUR (unique per market).
    public let code: String
    /// 
    public let is_default: Bool?
    /// Sort position (default 0).
    public let position: Int?

    init(
        code: String,
        is_default: Bool?,
        position: Int?
    ) {
        self.code = code
        self.is_default = is_default
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCurrencyCreateRequest {
        return MarketCurrencyCreateRequest(
            code: map["code"] as! String,
            is_default: map["is_default"] as? Bool,
            position: map["position"] as? Int
        )
    }
}
