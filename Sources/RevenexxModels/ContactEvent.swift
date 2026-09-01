import Foundation
import JSONCodable

/// One entry on a customer's timeline: an activity somebody logged (call, visit, note) or a registration decision this app recorded. Append-only — nothing here is ever edited.
open class ContactEvent: Codable {

    enum CodingKeys: String, CodingKey {
        case actor = "actor"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case id = "id"
        case kind = "kind"
        case name = "name"
        case occurred_at = "occurred_at"
        case organization_id = "organization_id"
        case payload = "payload"
        case subject = "subject"
        case tenant_id = "tenant_id"
    }

    /// Who logged the entry — free text as the client supplied it (operator id or email). Null for a row the app wrote itself.
    public let actor: String?
    /// The person this entry is about. Always set: even a company-level activity is filed against somebody, so a timeline never has anonymous rows.
    public let contact_id: String?
    /// When the row was written. Together with `occurred_at` this is what tells a late entry from a live one.
    public let created_at: String?
    /// Primary key of the timeline entry.
    public let id: String?
    /// What kind of entry this is — one of the tenant's own activity types (GET /customers/contact-event-kinds), seeded with note, call, email, meeting, visit, task. 'system' is reserved: those rows are this app's own registration decision trail and no caller may file one.
    public let kind: String?
    /// The event name, and the one vocabulary here that is THIS APP's rather than the tenant's: `registration.submitted` | `registration.approved` | `registration.rejected` for decisions, `activity.<kind>` for everything somebody logged. It is also what travels on the bus as `contact_event.created`.
    public let name: String?
    /// When the thing actually HAPPENED, which is not when it was written down: a call logged on Monday about Friday says Friday. Defaults to now.
    public let occurred_at: String?
    /// The company this entry belongs to, DERIVED from the contact and never taken from a request body — which is what stops a call with one company being filed under someone else's person. Null when the contact has no organization.
    public let organization_id: String?
    /// The machine-readable body, and its shape follows `name`. `activity.<kind>` carries `{ note }` — the long form of `subject`. `registration.submitted` carries the application itself: email, organization_id, organization_name, role, locale, vat_id, and `notify`, the recipients the approval mail goes to. `registration.approved` carries `{ decided_by }`; `registration.rejected` adds `reason`. Nothing validates it beyond that — a client writing its own entries decides what belongs in here.
    public let payload: [String: AnyCodable]?
    /// One line a person can scan in a timeline. Required for an activity; a decision row carries the app's own wording.
    public let subject: String?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?

    init(
        actor: String?,
        contact_id: String?,
        created_at: String?,
        id: String?,
        kind: String?,
        name: String?,
        occurred_at: String?,
        organization_id: String?,
        payload: [String: AnyCodable]?,
        subject: String?,
        tenant_id: String?
    ) {
        self.actor = actor
        self.contact_id = contact_id
        self.created_at = created_at
        self.id = id
        self.kind = kind
        self.name = name
        self.occurred_at = occurred_at
        self.organization_id = organization_id
        self.payload = payload
        self.subject = subject
        self.tenant_id = tenant_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.actor = try container.decodeIfPresent(String.self, forKey: .actor)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.occurred_at = try container.decodeIfPresent(String.self, forKey: .occurred_at)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.payload = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payload)
        self.subject = try container.decodeIfPresent(String.self, forKey: .subject)
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(actor, forKey: .actor)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(occurred_at, forKey: .occurred_at)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(payload, forKey: .payload)
        try container.encodeIfPresent(subject, forKey: .subject)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "actor": actor as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "kind": kind as Any,
            "name": name as Any,
            "occurred_at": occurred_at as Any,
            "organization_id": organization_id as Any,
            "payload": payload as Any,
            "subject": subject as Any,
            "tenant_id": tenant_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactEvent {
        return ContactEvent(
            actor: map["actor"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            kind: map["kind"] as? String,
            name: map["name"] as? String,
            occurred_at: map["occurred_at"] as? String,
            organization_id: map["organization_id"] as? String,
            payload: map["payload"] as? [String: AnyCodable],
            subject: map["subject"] as? String,
            tenant_id: map["tenant_id"] as? String
        )
    }
}
