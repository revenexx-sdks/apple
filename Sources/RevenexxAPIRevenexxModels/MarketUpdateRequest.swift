import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Partial update — omitted fields keep their current value.
open class MarketUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case currency = "currency"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
    }

    /// Market code (unique per tenant).
    public let code: String?
    /// ISO 4217 code (default &#039;EUR&#039;).
    public let currency: String?
    /// 
    public let is_default: Bool?
    /// Localized display names ({locale: label}).
    public let labels: [String: AnyCodable]?
    /// 
    public let name: String?
    /// Sort position (default 0).
    public let position: Int?
    /// Default &#039;active&#039;.
    public let status: Revenexx API — revenexxEnums.MarketStatus?

    init(
        code: String?,
        currency: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        status: Revenexx API — revenexxEnums.MarketStatus?
    ) {
        self.code = code
        self.currency = currency
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = Revenexx API — revenexxEnums.MarketStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "currency": currency as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketUpdateRequest {
        return MarketUpdateRequest(
            code: map["code"] as? String,
            currency: map["currency"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? MarketStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
