import Foundation
import JSONCodable
import RevenexxEnums

/// Tax resolution status of this answer. resolved=false ⇒ tax_class/tax_rate are unknown, NOT zero.
open class ShippingTaxContext: Codable {

    enum CodingKeys: String, CodingKey {
        case market_id = "market_id"
        case message = "message"
        case reason = "reason"
        case resolved = "resolved"
        case source = "source"
        case via = "via"
    }

    /// The market whose tax classes were applied.
    public let market_id: String?
    /// Human-readable form of `reason`, safe to log or show an operator. One sentence per reason; the example is the `no_markets` wording.
    public let message: String?
    /// Only when resolved=false — why no rate could be applied.
    public let reason: RevenexxEnums.ShippingTaxUnresolvedReason?
    /// Whether a tax rate could be applied at all. FALSE means every rate's tax_class and tax_rate are UNKNOWN — not zero, and not tax-free. A checkout that adds 0 % on this is wrong; read `reason` and either ask for a market or refuse to quote.
    public let resolved: Bool?
    /// Where the market came from: 'request' (market_id), 'header' (x-revenexx-market), 'country' (the market matching the destination) or 'sole_market' (the tenant has exactly one).
    public let source: RevenexxEnums.ShippingTaxMarketSource?
    /// Present when the market is known but registers no tax classes and the tenant's default_shipping_tax_rate supplied the number instead.
    public let via: RevenexxEnums.ShippingTaxContextVia?

    init(
        market_id: String?,
        message: String?,
        reason: RevenexxEnums.ShippingTaxUnresolvedReason?,
        resolved: Bool?,
        source: RevenexxEnums.ShippingTaxMarketSource?,
        via: RevenexxEnums.ShippingTaxContextVia?
    ) {
        self.market_id = market_id
        self.message = message
        self.reason = reason
        self.resolved = resolved
        self.source = source
        self.via = via
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        if let reasonString = try container.decodeIfPresent(String.self, forKey: .reason) {
            self.reason = RevenexxEnums.ShippingTaxUnresolvedReason(rawValue: reasonString)
        } else {
            self.reason = nil
        }
        self.resolved = try container.decodeIfPresent(Bool.self, forKey: .resolved)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ShippingTaxMarketSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        if let viaString = try container.decodeIfPresent(String.self, forKey: .via) {
            self.via = RevenexxEnums.ShippingTaxContextVia(rawValue: viaString)
        } else {
            self.via = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(reason?.rawValue, forKey: .reason)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(via?.rawValue, forKey: .via)
    }

    public func toMap() -> [String: Any] {
        return [
            "market_id": market_id as Any,
            "message": message as Any,
            "reason": reason?.rawValue as Any,
            "resolved": resolved as Any,
            "source": source?.rawValue as Any,
            "via": via?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingTaxContext {
        return ShippingTaxContext(
            market_id: map["market_id"] as? String,
            message: map["message"] as? String,
            reason: map["reason"] as? String != nil ? ShippingTaxUnresolvedReason(rawValue: map["reason"] as! String) : nil,
            resolved: map["resolved"] as? Bool,
            source: map["source"] as? String != nil ? ShippingTaxMarketSource(rawValue: map["source"] as! String) : nil,
            via: map["via"] as? String != nil ? ShippingTaxContextVia(rawValue: map["via"] as! String) : nil
        )
    }
}
