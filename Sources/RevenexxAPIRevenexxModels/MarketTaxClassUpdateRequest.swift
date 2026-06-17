import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class MarketTaxClassUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case rate = "rate"
    }

    /// Tax class code (unique per market).
    public let code: String?
    /// 
    public let is_default: Bool?
    /// Localized display names ({locale: label}).
    public let labels: [String: AnyCodable]?
    /// 
    public let name: String?
    /// Sort position (default 0).
    public let position: Int?
    /// Tax rate in percent, 0–100 (default 0).
    public let rate: Double?

    init(
        code: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        rate: Double?
    ) {
        self.code = code
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.rate = rate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rate, forKey: .rate)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "rate": rate as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketTaxClassUpdateRequest {
        return MarketTaxClassUpdateRequest(
            code: map["code"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            rate: map["rate"] as? Double
        )
    }
}
