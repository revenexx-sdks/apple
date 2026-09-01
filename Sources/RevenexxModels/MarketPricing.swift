import Foundation
import JSONCodable
import RevenexxEnums

/// Whether a stored price in this market is NET or GROSS — the market layer of an answer the prices app also holds. A price list's own tax_basis wins over this; `tax_basis: null` with `source: 'unset'` means this market declares nothing and the reader must fall through to the tenant's own default.
open class MarketPricing: Codable {

    enum CodingKeys: String, CodingKey {
        case prices_include_tax = "prices_include_tax"
        case source = "source"
        case tax_basis = "tax_basis"
    }

    /// The raw `prices_include_tax` setting resolved for this market. Null means the market declares nothing — it is NOT a false, and turning it into one is the bug this key exists to prevent.
    public let prices_include_tax: Bool?
    /// Where the value came from. 'market' — configured on this market. 'tenant' — the market holds no value of its own and the tenant baseline answered. 'unset' — nothing is configured anywhere in this app, and the reader must fall through to the prices app's tax_inclusive_default.
    public let source: RevenexxEnums.MarketPricingSource?
    /// The same answer in the prices app's own vocabulary, so the two halves of the platform use one word: 'gross' means a stored price already contains tax, 'net' means tax is added on top. Null means fall through to the tenant's own default.
    public let tax_basis: RevenexxEnums.MarketTaxBasis?

    init(
        prices_include_tax: Bool?,
        source: RevenexxEnums.MarketPricingSource?,
        tax_basis: RevenexxEnums.MarketTaxBasis?
    ) {
        self.prices_include_tax = prices_include_tax
        self.source = source
        self.tax_basis = tax_basis
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.prices_include_tax = try container.decodeIfPresent(Bool.self, forKey: .prices_include_tax)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.MarketPricingSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        if let tax_basisString = try container.decodeIfPresent(String.self, forKey: .tax_basis) {
            self.tax_basis = RevenexxEnums.MarketTaxBasis(rawValue: tax_basisString)
        } else {
            self.tax_basis = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(prices_include_tax, forKey: .prices_include_tax)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(tax_basis?.rawValue, forKey: .tax_basis)
    }

    public func toMap() -> [String: Any] {
        return [
            "prices_include_tax": prices_include_tax as Any,
            "source": source?.rawValue as Any,
            "tax_basis": tax_basis?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketPricing {
        return MarketPricing(
            prices_include_tax: map["prices_include_tax"] as? Bool,
            source: map["source"] as? String != nil ? MarketPricingSource(rawValue: map["source"] as! String) : nil,
            tax_basis: map["tax_basis"] as? String != nil ? MarketTaxBasis(rawValue: map["tax_basis"] as! String) : nil
        )
    }
}
