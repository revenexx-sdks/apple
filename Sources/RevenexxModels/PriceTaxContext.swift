import Foundation
import JSONCodable
import RevenexxEnums

/// Tax resolution status of this answer. resolved=false ⇒ tax_class/tax_rate are unknown, NOT zero.
open class PriceTaxContext: Codable {

    enum CodingKeys: String, CodingKey {
        case market_id = "market_id"
        case message = "message"
        case reason = "reason"
        case resolved = "resolved"
        case source = "source"
    }

    /// The market whose tax classes were applied.
    public let market_id: String?
    /// Human-readable form of `reason`, in English. Safe to log; not phrased for a buyer.
    public let message: String?
    /// Only when resolved=false — why no rate could be applied.
    public let reason: RevenexxEnums.PriceTaxUnresolvedReason?
    /// true ⇒ every priced item carries `tax_class`, `tax_rate`, `unit_price_net` and `unit_price_gross`. false ⇒ those are null because the rate could not be established — read `reason`, and never as "no tax due".
    public let resolved: Bool?
    /// Where the market came from: 'request' (market_id), 'header' (x-revenexx-market) or 'sole_market' (the tenant has exactly one).
    public let source: RevenexxEnums.PriceTaxMarketSource?

    init(
        market_id: String?,
        message: String?,
        reason: RevenexxEnums.PriceTaxUnresolvedReason?,
        resolved: Bool?,
        source: RevenexxEnums.PriceTaxMarketSource?
    ) {
        self.market_id = market_id
        self.message = message
        self.reason = reason
        self.resolved = resolved
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        if let reasonString = try container.decodeIfPresent(String.self, forKey: .reason) {
            self.reason = RevenexxEnums.PriceTaxUnresolvedReason(rawValue: reasonString)
        } else {
            self.reason = nil
        }
        self.resolved = try container.decodeIfPresent(Bool.self, forKey: .resolved)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.PriceTaxMarketSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(reason?.rawValue, forKey: .reason)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "market_id": market_id as Any,
            "message": message as Any,
            "reason": reason?.rawValue as Any,
            "resolved": resolved as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceTaxContext {
        return PriceTaxContext(
            market_id: map["market_id"] as? String,
            message: map["message"] as? String,
            reason: map["reason"] as? String != nil ? PriceTaxUnresolvedReason(rawValue: map["reason"] as! String) : nil,
            resolved: map["resolved"] as? Bool,
            source: map["source"] as? String != nil ? PriceTaxMarketSource(rawValue: map["source"] as! String) : nil
        )
    }
}
