import Foundation
import JSONCodable
import RevenexxEnums

/// The path id is the SOURCE market (a uuid or a market code). Everything the new market does not inherit is here. The copy flags default to true; `is_default` is never copied, and the new market always gets its own base currency registered and marked default.
open class MarketCloneRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case copy_currencies = "copy_currencies"
        case copy_locales = "copy_locales"
        case copy_tax_classes = "copy_tax_classes"
        case currency = "currency"
        case name = "name"
        case status = "status"
    }

    /// Code of the NEW market (unique per tenant).
    public let code: String
    /// Copy the source's traded currencies. Default true. The new market's own base currency is registered and marked default either way.
    public let copy_currencies: Bool?
    /// Copy the source's locales. Default true. False leaves the new market with no language of its own, so the tenant fallback_locale is seeded instead — it is never left with none.
    public let copy_locales: Bool?
    /// Copy the source's tax classes, rates and all. Default true. False leaves the market unable to tax anything, which readiness reports as blocking.
    public let copy_tax_classes: Bool?
    /// Base currency of the new market (ISO 4217). Defaults to the source market's, and is registered and marked default on the new one either way.
    public let currency: String?
    /// Display name of the new market. Defaults to its code.
    public let name: String?
    /// Status of the new market. Defaults to 'active'; clone it 'inactive' to build it out before it serves anyone.
    public let status: RevenexxEnums.MarketStatus?

    init(
        code: String,
        copy_currencies: Bool?,
        copy_locales: Bool?,
        copy_tax_classes: Bool?,
        currency: String?,
        name: String?,
        status: RevenexxEnums.MarketStatus?
    ) {
        self.code = code
        self.copy_currencies = copy_currencies
        self.copy_locales = copy_locales
        self.copy_tax_classes = copy_tax_classes
        self.currency = currency
        self.name = name
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.copy_currencies = try container.decodeIfPresent(Bool.self, forKey: .copy_currencies)
        self.copy_locales = try container.decodeIfPresent(Bool.self, forKey: .copy_locales)
        self.copy_tax_classes = try container.decodeIfPresent(Bool.self, forKey: .copy_tax_classes)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.MarketStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(copy_currencies, forKey: .copy_currencies)
        try container.encodeIfPresent(copy_locales, forKey: .copy_locales)
        try container.encodeIfPresent(copy_tax_classes, forKey: .copy_tax_classes)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "copy_currencies": copy_currencies as Any,
            "copy_locales": copy_locales as Any,
            "copy_tax_classes": copy_tax_classes as Any,
            "currency": currency as Any,
            "name": name as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketCloneRequest {
        return MarketCloneRequest(
            code: map["code"] as! String,
            copy_currencies: map["copy_currencies"] as? Bool,
            copy_locales: map["copy_locales"] as? Bool,
            copy_tax_classes: map["copy_tax_classes"] as? Bool,
            currency: map["currency"] as? String,
            name: map["name"] as? String,
            status: map["status"] as? String != nil ? MarketStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
