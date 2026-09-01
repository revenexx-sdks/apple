import Foundation
import JSONCodable
import RevenexxEnums

/// A price list: one currency, one tax basis, one validity window, one buyer scope — and the entries that price items in it. Which list wins for a given buyer is decided by scope first, then priority, then the default flag; see prices.resolve.
open class PriceList: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case code = "code"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case description = "description"
        case id = "id"
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
        case updated_at = "updated_at"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// Buyer scope: this list prices for this sales channel. Beats the open lists, loses to contact and organization scope.
    public let channel_id: String?
    /// The unique per-tenant handle of the list — what an import, an ERP export and every integration addresses it by, and what the `default_price_list_code` setting names. It is never quietly reassigned: a second list under a code that is taken answers 409.
    public let code: String?
    /// Buyer scope: this list prices for this one contact. The most specific scope there is — it beats organization, channel and every open list, whatever their priority.
    public let contact_id: String?
    /// When the list was created. Also the `newest` tie-break’s input when the tenant settles genuine ties that way.
    public let created_at: String?
    /// ISO 4217 currency of EVERY amount in this list — entries carry no currency of their own, so this is the one that governs them. Resolution only ever considers lists whose currency equals the currency of the call: a list in another currency is not converted, it simply does not price the item. This app never converts between currencies.
    public let currency: String?
    /// Free text for whoever maintains the list — why it exists and who it is for. Never shown to a buyer.
    public let description: String?
    /// The price list itself. Every sub-route addresses the list by this id, and a resolve answer names the list that priced an item under `price_list.id`.
    public let id: String?
    /// The fallback list. Within its group it deliberately sorts LAST, so a default list wins only where nothing more specific priced the item. At most one list per tenant holds the flag — `prices.lists.make-default` moves it in one call.
    public let is_default: Bool?
    /// Localised names, keyed by language tag: {"de": "Standardpreise", "en": "Standard prices"}. Read the tag you need and fall back to `en`; `name` is the untranslated original.
    public let labels: [String: AnyCodable]?
    /// Free-form bag, unvalidated and never read by this app: whatever JSON object you write round-trips exactly. Its keys are the integration’s own — ERP provenance is the usual content, e.g. {"source_system": "erp", "erp_price_group": "A1"}.
    public let metadata: [String: AnyCodable]?
    /// Operator-facing name, shown wherever a human picks a list. Not addressable — integrations join on `code`.
    public let name: String?
    /// Buyer scope: this list prices for buyers of this organization. Beats channel-scoped and open lists, loses to a contact-scoped one.
    public let organization_id: String?
    /// Tie-break WITHIN one specificity group, higher first. It never beats specificity: an organization-scoped list at priority 0 still wins over an open list at priority 100. Default 0.
    public let priority: Int?
    /// Gate: when true the list resolves only for a buyer who has a contact or organization context. An anonymous resolve never matches it, so a tenant that prices only for logged-in customers flags its list and guests fall through to price-on-request rather than to some other list’s number.
    public let requires_auth: Bool?
    /// Whether the list takes part in resolution at all. Only `active` lists are candidates; `inactive` retires a list without deleting the prices it holds.
    public let status: RevenexxEnums.PriceListStatus?
    /// Whether the amounts stored in this list are `net` (tax excluded) or `gross` (tax included) — the one fact a price cannot be without. null inherits the tenant’s `tax_inclusive_default` setting, and the resolve answer names which of the two decided under `tax_basis_source`.
    public let tax_basis: RevenexxEnums.PriceListTaxBasis?
    /// LEGACY mirror of `tax_basis`. `false` is the column default, so it is NOT read as anybody having chosen net; only `true` is read as a statement (gross), and only where `tax_basis` is null. Prefer `tax_basis`.
    public let tax_included: Bool?
    /// When the row last changed. Written by the database, not by the caller.
    public let updated_at: String?
    /// Start of the validity window of the WHOLE list; null = open-ended. Outside the window the list is not a candidate at all. The instant compared against is the resolve call’s `at`, echoed as `basis.evaluated_at`.
    public let valid_from: String?
    /// End of the validity window of the whole list; null = open-ended. Use it to let a season expire on its own instead of deactivating a list by hand.
    public let valid_until: String?

    init(
        channel_id: String?,
        code: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        description: String?,
        id: String?,
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
        updated_at: String?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.channel_id = channel_id
        self.code = code
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.description = description
        self.id = id
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
        self.updated_at = updated_at
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
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
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(id, forKey: .id)
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
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "code": code as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "description": description as Any,
            "id": id as Any,
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
            "updated_at": updated_at as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceList {
        return PriceList(
            channel_id: map["channel_id"] as? String,
            code: map["code"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            id: map["id"] as? String,
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
            updated_at: map["updated_at"] as? String,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
