import Foundation
import JSONCodable
import RevenexxEnums

/// One question asked of the market, its verdict, and how much the answer costs.
open class MarketReadinessCheck: Codable {

    enum CodingKeys: String, CodingKey {
        case detail = "detail"
        case id = "id"
        case ok = "ok"
        case severity = "severity"
    }

    /// One sentence naming what was found and, for a warning, what covers for it.
    public let detail: String?
    /// Which question. 'locales' — is there a language to render in? 'currencies' — is the base currency registered and marked default? 'tax_classes' — is there a rate to tax with? 'tax_basis' — informational, restating whether stored prices are gross or net.
    public let id: RevenexxEnums.MarketReadinessCheckId?
    /// Whether this check passed. A false with severity `info` cannot occur — the informational check always passes.
    public let ok: Bool?
    /// What a failure costs. 'blocking' — the market cannot trade. 'warning' — degraded but serviceable, and `detail` names what covers for it. 'info' — a fact worth reporting that is never a failure. The severity is not fixed per check: no locales is blocking without a tenant fallback_locale and a warning with one.
    public let severity: RevenexxEnums.MarketReadinessSeverity?

    init(
        detail: String?,
        id: RevenexxEnums.MarketReadinessCheckId?,
        ok: Bool?,
        severity: RevenexxEnums.MarketReadinessSeverity?
    ) {
        self.detail = detail
        self.id = id
        self.ok = ok
        self.severity = severity
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
        if let idString = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = RevenexxEnums.MarketReadinessCheckId(rawValue: idString)
        } else {
            self.id = nil
        }
        self.ok = try container.decodeIfPresent(Bool.self, forKey: .ok)
        if let severityString = try container.decodeIfPresent(String.self, forKey: .severity) {
            self.severity = RevenexxEnums.MarketReadinessSeverity(rawValue: severityString)
        } else {
            self.severity = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(detail, forKey: .detail)
        try container.encodeIfPresent(id?.rawValue, forKey: .id)
        try container.encodeIfPresent(ok, forKey: .ok)
        try container.encodeIfPresent(severity?.rawValue, forKey: .severity)
    }

    public func toMap() -> [String: Any] {
        return [
            "detail": detail as Any,
            "id": id?.rawValue as Any,
            "ok": ok as Any,
            "severity": severity?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketReadinessCheck {
        return MarketReadinessCheck(
            detail: map["detail"] as? String,
            id: map["id"] as? String != nil ? MarketReadinessCheckId(rawValue: map["id"] as! String) : nil,
            ok: map["ok"] as? Bool,
            severity: map["severity"] as? String != nil ? MarketReadinessSeverity(rawValue: map["severity"] as! String) : nil
        )
    }
}
