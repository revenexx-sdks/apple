import Foundation
import JSONCodable
import RevenexxEnums

/// The policy this answer was computed under — the tenant settings in force plus where the currency came from.
open class PriceResolveBasis: Codable {

    enum CodingKeys: String, CodingKey {
        case anonymous_resolve_allowed = "anonymous_resolve_allowed"
        case currency_source = "currency_source"
        case evaluated_at = "evaluated_at"
        case price_list_priority_tiebreak = "price_list_priority_tiebreak"
        case price_precision = "price_precision"
        case rounding_mode = "rounding_mode"
        case tax_inclusive_default = "tax_inclusive_default"
    }

    /// false ⇒ a buyer with no contact/organization is answered on_request for everything.
    public let anonymous_resolve_allowed: Bool?
    /// Where `currency` came from: the request, the buyer market's own currency, the tenant's default_currency setting, or the shipped fallback.
    public let currency_source: RevenexxEnums.PriceCurrencySource?
    /// The instant validity windows were evaluated at.
    public let evaluated_at: String?
    /// Which list won where specificity and priority tied.
    public let price_list_priority_tiebreak: RevenexxEnums.PriceListTiebreak?
    /// Decimals every DERIVED amount (net, gross, line totals) was rounded to.
    public let price_precision: Int?
    /// How those amounts landed on the last decimal.
    public let rounding_mode: RevenexxEnums.PriceRoundingMode?
    /// Tenant setting: the basis a price list that states none is read on.
    public let tax_inclusive_default: RevenexxEnums.PriceTaxInclusiveDefault?

    init(
        anonymous_resolve_allowed: Bool?,
        currency_source: RevenexxEnums.PriceCurrencySource?,
        evaluated_at: String?,
        price_list_priority_tiebreak: RevenexxEnums.PriceListTiebreak?,
        price_precision: Int?,
        rounding_mode: RevenexxEnums.PriceRoundingMode?,
        tax_inclusive_default: RevenexxEnums.PriceTaxInclusiveDefault?
    ) {
        self.anonymous_resolve_allowed = anonymous_resolve_allowed
        self.currency_source = currency_source
        self.evaluated_at = evaluated_at
        self.price_list_priority_tiebreak = price_list_priority_tiebreak
        self.price_precision = price_precision
        self.rounding_mode = rounding_mode
        self.tax_inclusive_default = tax_inclusive_default
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.anonymous_resolve_allowed = try container.decodeIfPresent(Bool.self, forKey: .anonymous_resolve_allowed)
        if let currency_sourceString = try container.decodeIfPresent(String.self, forKey: .currency_source) {
            self.currency_source = RevenexxEnums.PriceCurrencySource(rawValue: currency_sourceString)
        } else {
            self.currency_source = nil
        }
        self.evaluated_at = try container.decodeIfPresent(String.self, forKey: .evaluated_at)
        if let price_list_priority_tiebreakString = try container.decodeIfPresent(String.self, forKey: .price_list_priority_tiebreak) {
            self.price_list_priority_tiebreak = RevenexxEnums.PriceListTiebreak(rawValue: price_list_priority_tiebreakString)
        } else {
            self.price_list_priority_tiebreak = nil
        }
        self.price_precision = try container.decodeIfPresent(Int.self, forKey: .price_precision)
        if let rounding_modeString = try container.decodeIfPresent(String.self, forKey: .rounding_mode) {
            self.rounding_mode = RevenexxEnums.PriceRoundingMode(rawValue: rounding_modeString)
        } else {
            self.rounding_mode = nil
        }
        if let tax_inclusive_defaultString = try container.decodeIfPresent(String.self, forKey: .tax_inclusive_default) {
            self.tax_inclusive_default = RevenexxEnums.PriceTaxInclusiveDefault(rawValue: tax_inclusive_defaultString)
        } else {
            self.tax_inclusive_default = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(anonymous_resolve_allowed, forKey: .anonymous_resolve_allowed)
        try container.encodeIfPresent(currency_source?.rawValue, forKey: .currency_source)
        try container.encodeIfPresent(evaluated_at, forKey: .evaluated_at)
        try container.encodeIfPresent(price_list_priority_tiebreak?.rawValue, forKey: .price_list_priority_tiebreak)
        try container.encodeIfPresent(price_precision, forKey: .price_precision)
        try container.encodeIfPresent(rounding_mode?.rawValue, forKey: .rounding_mode)
        try container.encodeIfPresent(tax_inclusive_default?.rawValue, forKey: .tax_inclusive_default)
    }

    public func toMap() -> [String: Any] {
        return [
            "anonymous_resolve_allowed": anonymous_resolve_allowed as Any,
            "currency_source": currency_source?.rawValue as Any,
            "evaluated_at": evaluated_at as Any,
            "price_list_priority_tiebreak": price_list_priority_tiebreak?.rawValue as Any,
            "price_precision": price_precision as Any,
            "rounding_mode": rounding_mode?.rawValue as Any,
            "tax_inclusive_default": tax_inclusive_default?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceResolveBasis {
        return PriceResolveBasis(
            anonymous_resolve_allowed: map["anonymous_resolve_allowed"] as? Bool,
            currency_source: map["currency_source"] as? String != nil ? PriceCurrencySource(rawValue: map["currency_source"] as! String) : nil,
            evaluated_at: map["evaluated_at"] as? String,
            price_list_priority_tiebreak: map["price_list_priority_tiebreak"] as? String != nil ? PriceListTiebreak(rawValue: map["price_list_priority_tiebreak"] as! String) : nil,
            price_precision: map["price_precision"] as? Int,
            rounding_mode: map["rounding_mode"] as? String != nil ? PriceRoundingMode(rawValue: map["rounding_mode"] as! String) : nil,
            tax_inclusive_default: map["tax_inclusive_default"] as? String != nil ? PriceTaxInclusiveDefault(rawValue: map["tax_inclusive_default"] as! String) : nil
        )
    }
}
