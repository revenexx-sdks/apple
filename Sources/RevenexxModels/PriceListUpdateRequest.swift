import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class PriceListUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case code = "code"
        case contact_id = "contact_id"
        case currency = "currency"
        case description = "description"
        case is_default = "is_default"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case organization_id = "organization_id"
        case priority = "priority"
        case requires_auth = "requires_auth"
        case status = "status"
        case tax_basis = "tax_basis"
        case tax_included = "tax_included"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// Scope: only this sales channel. Beats the open lists, loses to contact and organization.
    public let channel_id: String?
    /// Unique list code per tenant — the handle every import and integration addresses this list by. A code already in use answers 409.
    public let code: String?
    /// Scope: only this contact. The most specific scope there is — it beats organization, channel and every open list, whatever their priority.
    public let contact_id: String?
    /// ISO 4217 code (default EUR) — the currency of EVERY amount in this list, since entries carry none of their own. Resolution only considers lists matching the currency of the call; nothing is ever converted.
    public let currency: String?
    /// Free text for whoever maintains the list — why it exists and who it is for. Never shown to a buyer.
    public let description: String?
    /// The fallback list. Within its group it sorts LAST, so it wins only where nothing more specific priced the item. Use prices.lists.make-default to move the flag rather than setting it here — two defaults leave a tie to row order.
    public let is_default: Bool?
    /// Localised names, keyed by language tag — {"de": "Händlerpreise", "en": "Dealer prices"}. Omit to show `name` everywhere.
    public let labels: [String: AnyCodable]?
    /// Free-form bag: whatever JSON object you write round-trips exactly, and this app never reads it. Its keys are yours — ERP provenance is the usual content.
    public let metadata: [String: AnyCodable]?
    /// Operator-facing name, shown wherever a human picks a list.
    public let name: String?
    /// Scope: only buyers of this organization. Beats channel-scoped and open lists.
    public let organization_id: String?
    /// Tie-break WITHIN a specificity group (higher wins, default 0). It never beats scope: an organization list at 0 still wins over an open list at 100.
    public let priority: Int?
    /// Gate: when true the list resolves only for an authenticated buyer (contact or organization context); anonymous resolve calls get on_request. Default false (open to everyone).
    public let requires_auth: Bool?
    /// Default 'active' — only active lists resolve. 'inactive' retires a list without deleting its prices.
    public let status: RevenexxEnums.PriceListStatus?
    /// Whether the amounts in this list are net (tax excluded) or gross (tax included) — the one fact a price cannot be without. Omit (null) to inherit the tenant's tax_inclusive_default setting; the resolve answer names which of the two decided under tax_basis_source.
    public let tax_basis: RevenexxEnums.PriceListTaxBasis?
    /// LEGACY mirror of tax_basis. false is the column default and is NOT read as a statement of intent; true is read as gross, and only where tax_basis is null. Prefer tax_basis.
    public let tax_included: Bool?
    /// Start of the validity window of the WHOLE list (ISO 8601); null = open-ended. Outside it the list is not a candidate at all.
    public let valid_from: String?
    /// End of the validity window of the whole list; null = open-ended. Lets a season expire on its own instead of being deactivated by hand.
    public let valid_until: String?

    init(
        channel_id: String?,
        code: String?,
        contact_id: String?,
        currency: String?,
        description: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        metadata: [String: AnyCodable]?,
        name: String?,
        organization_id: String?,
        priority: Int?,
        requires_auth: Bool?,
        status: RevenexxEnums.PriceListStatus?,
        tax_basis: RevenexxEnums.PriceListTaxBasis?,
        tax_included: Bool?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.channel_id = channel_id
        self.code = code
        self.contact_id = contact_id
        self.currency = currency
        self.description = description
        self.is_default = is_default
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.organization_id = organization_id
        self.priority = priority
        self.requires_auth = requires_auth
        self.status = status
        self.tax_basis = tax_basis
        self.tax_included = tax_included
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.requires_auth = try container.decodeIfPresent(Bool.self, forKey: .requires_auth)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.PriceListStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        if let tax_basisString = try container.decodeIfPresent(String.self, forKey: .tax_basis) {
            self.tax_basis = RevenexxEnums.PriceListTaxBasis(rawValue: tax_basisString)
        } else {
            self.tax_basis = nil
        }
        self.tax_included = try container.decodeIfPresent(Bool.self, forKey: .tax_included)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(requires_auth, forKey: .requires_auth)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(tax_basis?.rawValue, forKey: .tax_basis)
        try container.encodeIfPresent(tax_included, forKey: .tax_included)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "code": code as Any,
            "contact_id": contact_id as Any,
            "currency": currency as Any,
            "description": description as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "organization_id": organization_id as Any,
            "priority": priority as Any,
            "requires_auth": requires_auth as Any,
            "status": status?.rawValue as Any,
            "tax_basis": tax_basis?.rawValue as Any,
            "tax_included": tax_included as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceListUpdateRequest {
        return PriceListUpdateRequest(
            channel_id: map["channel_id"] as? String,
            code: map["code"] as? String,
            contact_id: map["contact_id"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            organization_id: map["organization_id"] as? String,
            priority: map["priority"] as? Int,
            requires_auth: map["requires_auth"] as? Bool,
            status: map["status"] as? String != nil ? PriceListStatus(rawValue: map["status"] as! String) : nil,
            tax_basis: map["tax_basis"] as? String != nil ? PriceListTaxBasis(rawValue: map["tax_basis"] as! String) : nil,
            tax_included: map["tax_included"] as? Bool,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
