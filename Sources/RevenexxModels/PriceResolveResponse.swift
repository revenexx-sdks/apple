import Foundation
import JSONCodable

/// One answer per requested item, in request order, plus the currency, the tax context and the policy the numbers were computed under.
open class PriceResolveResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case basis = "basis"
        case currency = "currency"
        case prices = "prices"
        case tax = "tax"
    }

    /// The policy this answer was computed under — the tenant settings in force plus where the currency came from.
    public let basis: PriceResolveBasis?
    /// ISO 4217 currency the whole answer is quoted in, and the currency lists had to match to be candidates at all. `basis.currency_source` says where it came from: the request, the buyer market, the tenant setting, or the shipped fallback.
    public let currency: String?
    /// One entry per requested item, in the order the items were sent. An item that could not be priced is present and `on_request`, never missing.
    public let prices: [ResolvedPrice]?
    /// Tax resolution status of this answer. resolved=false ⇒ tax_class/tax_rate are unknown, NOT zero.
    public let tax: PriceTaxContext?

    init(
        basis: PriceResolveBasis?,
        currency: String?,
        prices: [ResolvedPrice]?,
        tax: PriceTaxContext?
    ) {
        self.basis = basis
        self.currency = currency
        self.prices = prices
        self.tax = tax
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.basis = try container.decodeIfPresent(PriceResolveBasis.self, forKey: .basis)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.prices = try container.decodeIfPresent([ResolvedPrice].self, forKey: .prices)
        self.tax = try container.decodeIfPresent(PriceTaxContext.self, forKey: .tax)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(basis, forKey: .basis)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(prices, forKey: .prices)
        try container.encodeIfPresent(tax, forKey: .tax)
    }

    public func toMap() -> [String: Any] {
        return [
            "basis": basis?.toMap() as Any,
            "currency": currency as Any,
            "prices": prices?.map { $0.toMap() } as Any,
            "tax": tax?.toMap() as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceResolveResponse {
        return PriceResolveResponse(
            basis: PriceResolveBasis.from(map: map["basis"] as! [String: Any]),
            currency: map["currency"] as? String,
            prices: (map["prices"] as? [[String: Any]] ?? []).map { ResolvedPrice.from(map: $0) },
            tax: PriceTaxContext.from(map: map["tax"] as! [String: Any])
        )
    }
}
