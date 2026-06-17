import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class MarketLocaleUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "country"
        case is_default = "is_default"
        case language = "language"
        case position = "position"
    }

    /// Locale code, e.g. &#039;de-DE&#039; (unique per market).
    public let code: String?
    /// ISO 3166-1 alpha-2 country code.
    public let country: String?
    /// 
    public let is_default: Bool?
    /// ISO 639-1 language code.
    public let language: String?
    /// Sort position (default 0).
    public let position: Int?

    init(
        code: String?,
        country: String?,
        is_default: Bool?,
        language: String?,
        position: Int?
    ) {
        self.code = code
        self.country = country
        self.is_default = is_default
        self.language = language
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "country": country as Any,
            "is_default": is_default as Any,
            "language": language as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocaleUpdateRequest {
        return MarketLocaleUpdateRequest(
            code: map["code"] as? String,
            country: map["country"] as? String,
            is_default: map["is_default"] as? Bool,
            language: map["language"] as? String,
            position: map["position"] as? Int
        )
    }
}
