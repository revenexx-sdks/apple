import Foundation
import JSONCodable

/// What in this app still points at a market tax class, by code.
open class ShippingTaxClassUsage: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case fallback_setting = "fallback_setting"
        case in_use = "in_use"
        case methods = "methods"
        case shipping_methods = "shipping_methods"
    }

    /// The tax-class code that was asked about, echoed back.
    public let code: String?
    /// True when this market's shipping_tax_class setting names the code — the class every method that names none falls back to.
    public let fallback_setting: Bool?
    /// True when at least one method or the market fallback setting names it. The single field a caller deciding whether to allow a delete needs; the rest is so it can word the refusal.
    public let in_use: Bool?
    /// The first 20 of them, so a refusal can name names instead of a number.
    public let methods: [[String: AnyCodable]]?
    /// How many methods name this code as their own tax_class. Capped at 500 — a tenant with more shipping methods than that has a bigger problem than an imprecise count.
    public let shipping_methods: Int?

    init(
        code: String?,
        fallback_setting: Bool?,
        in_use: Bool?,
        methods: [[String: AnyCodable]]?,
        shipping_methods: Int?
    ) {
        self.code = code
        self.fallback_setting = fallback_setting
        self.in_use = in_use
        self.methods = methods
        self.shipping_methods = shipping_methods
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.fallback_setting = try container.decodeIfPresent(Bool.self, forKey: .fallback_setting)
        self.in_use = try container.decodeIfPresent(Bool.self, forKey: .in_use)
        self.methods = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .methods)
        self.shipping_methods = try container.decodeIfPresent(Int.self, forKey: .shipping_methods)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(fallback_setting, forKey: .fallback_setting)
        try container.encodeIfPresent(in_use, forKey: .in_use)
        try container.encodeIfPresent(methods, forKey: .methods)
        try container.encodeIfPresent(shipping_methods, forKey: .shipping_methods)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "fallback_setting": fallback_setting as Any,
            "in_use": in_use as Any,
            "methods": methods as Any,
            "shipping_methods": shipping_methods as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingTaxClassUsage {
        return ShippingTaxClassUsage(
            code: map["code"] as? String,
            fallback_setting: map["fallback_setting"] as? Bool,
            in_use: map["in_use"] as? Bool,
            methods: map["methods"] as? [[String: AnyCodable]],
            shipping_methods: map["shipping_methods"] as? Int
        )
    }
}
