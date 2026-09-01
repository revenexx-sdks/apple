import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class FormSubmission<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case data = "data"
        case form_id = "form_id"
        case form_slug = "form_slug"
        case id = "id"
        case metadata = "metadata"
        case source = "source"
        case status = "status"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// When the submission arrived. This is the age the retention sweep measures against `submission_retention_days`, and the column an inbox sorts by (`order=created_at.desc`).
    public let created_at: String?
    /// What the visitor typed — the substance of the submission, and the reason this row is the payload of `form.submitted`.
    /// 
    /// It is an object keyed by the `name` of the definition node that collected each value, so the keys of a submission are the named nodes of its form's `definition` and nothing else. There is no fixed set of keys across forms: a contact form yields `{name, email, message}`, a price request whatever its operator built.
    /// 
    /// The VALUE type follows the input type, which is why this object is not typed further: a `text`, `email` or `textarea` yields a string, a `number` a number, a single `checkbox` a boolean, a `select`/`radio` the chosen option value, a multi-select or a checkbox set an array of them, and a `group` or `list` input nests an object or an array under its own name. Nothing coerces them — a value arrives as the storefront sent it and is stored as jsonb.
    /// 
    /// Two values are NOT here: the honeypot field, if the tenant configured one, is stripped before the row is written (it is a trap, not an answer the visitor gave), and the resolved notification recipient lives in `metadata`, not in what somebody typed.
    public let data: [String: AnyCodable]?
    /// The form this submission was made against. It is resolved at insert, so an id no form in this tenant holds is a 404 and nothing is stored — a submission with no form is a lead nobody can read.
    public let form_id: String?
    /// The form's slug as it stood when this submission arrived, copied onto the row: the inbox filters by form without a join, and a submission still says which form collected it after that form has been renamed. It does not outlive a DELETED form — the foreign key cascades and takes the submission with it. On a write the body's value WINS; omit it and the form's own slug is copied in.
    public let form_slug: String?
    /// The submission's own id — what the inbox links to, and what a workflow reading `form.submitted` gets handed.
    public let id: String?
    /// Free-form metadata, plus what this app stamped on at insert. The recipient is resolved ONCE, here, because this row is the payload of `form.submitted` — a workflow reads the address off the event instead of re-resolving a form's settings that may since have changed.
    public let metadata: FormSubmissionMetadata<T>?
    /// Where the submission came from. The storefront sends the `window.location.pathname` of the page that carried the form, so this is normally a path rather than an absolute URL; any other surface (an app, an import) puts its own name here. Null when the caller sent none.
    public let source: String?
    /// Inbox triage. `new` until somebody opens it, then `read`, and `archived` once it is dealt with. `spam` is set by code in exactly one place — the honeypot, and only while the tenant's spam_handling is 'flag'; under 'reject' the submission is never stored at all. Default 'new'.
    public let status: RevenexxEnums.FormSubmissionStatus?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?
    /// When the row was last written — a triage status change. It is not evidence about the submitted data, which under the shipped policy cannot change at all.
    public let updated_at: String?

    init(
        created_at: String?,
        data: [String: AnyCodable]?,
        form_id: String?,
        form_slug: String?,
        id: String?,
        metadata: FormSubmissionMetadata<T>?,
        source: String?,
        status: RevenexxEnums.FormSubmissionStatus?,
        tenant_id: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.data = data
        self.form_id = form_id
        self.form_slug = form_slug
        self.id = id
        self.metadata = metadata
        self.source = source
        self.status = status
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .data)
        self.form_id = try container.decodeIfPresent(String.self, forKey: .form_id)
        self.form_slug = try container.decodeIfPresent(String.self, forKey: .form_slug)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent(FormSubmissionMetadata<T>.self, forKey: .metadata)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.FormSubmissionStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(form_id, forKey: .form_id)
        try container.encodeIfPresent(form_slug, forKey: .form_slug)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "data": data as Any,
            "form_id": form_id as Any,
            "form_slug": form_slug as Any,
            "id": id as Any,
            "metadata": metadata?.toMap() as Any,
            "source": source as Any,
            "status": status?.rawValue as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmission {
        return FormSubmission(
            created_at: map["created_at"] as? String,
            data: map["data"] as? [String: AnyCodable],
            form_id: map["form_id"] as? String,
            form_slug: map["form_slug"] as? String,
            id: map["id"] as? String,
            metadata: FormSubmissionMetadata.from(map: map["metadata"] as! [String: Any]),
            source: map["source"] as? String,
            status: map["status"] as? String != nil ? FormSubmissionStatus(rawValue: map["status"] as! String) : nil,
            tenant_id: map["tenant_id"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
