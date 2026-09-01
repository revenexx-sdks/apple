import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — typically the inbox status change.
open class FormSubmissionUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case form_id = "form_id"
        case form_slug = "form_slug"
        case metadata = "metadata"
        case source = "source"
        case status = "status"
    }

    /// What the visitor typed — the substance of the submission, and the reason this row is the payload of `form.submitted`.
    /// 
    /// It is an object keyed by the `name` of the definition node that collected each value, so the keys of a submission are the named nodes of its form's `definition` and nothing else. There is no fixed set of keys across forms: a contact form yields `{name, email, message}`, a price request whatever its operator built.
    /// 
    /// The VALUE type follows the input type, which is why this object is not typed further: a `text`, `email` or `textarea` yields a string, a `number` a number, a single `checkbox` a boolean, a `select`/`radio` the chosen option value, a multi-select or a checkbox set an array of them, and a `group` or `list` input nests an object or an array under its own name. Nothing coerces them — a value arrives as the storefront sent it and is stored as jsonb.
    /// 
    /// Two values are NOT here: the honeypot field, if the tenant configured one, is stripped before the row is written (it is a trap, not an answer the visitor gave), and the resolved notification recipient lives in `metadata`, not in what somebody typed.
    public let data: [String: AnyCodable]?
    /// The form this submission was made against. It is resolved at insert, so an id no form in this tenant holds is a 404 and nothing is stored — a submission with no form is a lead nobody can read. Required on a create: it is the only thing that says which form was filled in.
    public let form_id: String?
    /// The form's slug as it stood when this submission arrived, copied onto the row: the inbox filters by form without a join, and a submission still says which form collected it after that form has been renamed. It does not outlive a DELETED form — the foreign key cascades and takes the submission with it. On a write the body's value WINS; omit it and the form's own slug is copied in. So: OPTIONAL — send it and it is stored as sent, even if it disagrees with the form; omit it and the form's own slug is filled in from `form_id`.
    public let form_slug: String?
    /// Free-form metadata, yours to key as an integration needs. The resolved notification recipient is merged OVER it at insert, so `notify_email` and `notify_source` sent here are overwritten — see the `FormSubmissionMetadata` schema.
    public let metadata: [String: AnyCodable]?
    /// Where the submission came from. The storefront sends the `window.location.pathname` of the page that carried the form, so this is normally a path rather than an absolute URL; any other surface (an app, an import) puts its own name here. Null when the caller sent none.
    public let source: String?
    /// Inbox triage. `new` until somebody opens it, then `read`, and `archived` once it is dealt with. `spam` is set by code in exactly one place — the honeypot, and only while the tenant's spam_handling is 'flag'; under 'reject' the submission is never stored at all. Default 'new'. A create may set it — an inbox importer records a submission that is already read — but nothing needs to: omit it and the row is 'new'.
    public let status: RevenexxEnums.FormSubmissionStatus?

    init(
        data: [String: AnyCodable]?,
        form_id: String?,
        form_slug: String?,
        metadata: [String: AnyCodable]?,
        source: String?,
        status: RevenexxEnums.FormSubmissionStatus?
    ) {
        self.data = data
        self.form_id = form_id
        self.form_slug = form_slug
        self.metadata = metadata
        self.source = source
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.data = try container.decodeIfPresent([String: AnyCodable].self, forKey: .data)
        self.form_id = try container.decodeIfPresent(String.self, forKey: .form_id)
        self.form_slug = try container.decodeIfPresent(String.self, forKey: .form_slug)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.FormSubmissionStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(form_id, forKey: .form_id)
        try container.encodeIfPresent(form_slug, forKey: .form_slug)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "data": data as Any,
            "form_id": form_id as Any,
            "form_slug": form_slug as Any,
            "metadata": metadata as Any,
            "source": source as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionUpdateRequest {
        return FormSubmissionUpdateRequest(
            data: map["data"] as? [String: AnyCodable],
            form_id: map["form_id"] as? String,
            form_slug: map["form_slug"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            source: map["source"] as? String,
            status: map["status"] as? String != nil ? FormSubmissionStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
