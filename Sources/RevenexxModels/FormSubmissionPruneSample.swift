import Foundation
import JSONCodable

/// One row the sweep would delete, shown so a merchant can recognise what is at stake before turning the preview off. Three columns only — never the submitted data.
open class FormSubmissionPruneSample: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case form_slug = "form_slug"
        case id = "id"
    }

    /// When it arrived — the age this sweep is judging it on.
    public let created_at: String?
    /// The form's slug as it stood when this submission arrived, copied onto the row: the inbox filters by form without a join, and a submission still says which form collected it after that form has been renamed. It does not outlive a DELETED form — the foreign key cascades and takes the submission with it. On a write the body's value WINS; omit it and the form's own slug is copied in.
    public let form_slug: String?
    /// The submission that would be deleted. Fetch it with GET /v1/forms/submissions/{id} to see what it holds.
    public let id: String?

    init(
        created_at: String?,
        form_slug: String?,
        id: String?
    ) {
        self.created_at = created_at
        self.form_slug = form_slug
        self.id = id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.form_slug = try container.decodeIfPresent(String.self, forKey: .form_slug)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(form_slug, forKey: .form_slug)
        try container.encodeIfPresent(id, forKey: .id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "form_slug": form_slug as Any,
            "id": id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionPruneSample {
        return FormSubmissionPruneSample(
            created_at: map["created_at"] as? String,
            form_slug: map["form_slug"] as? String,
            id: map["id"] as? String
        )
    }
}
