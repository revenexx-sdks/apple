import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, echoed with the values as they arrived. A query parameter that is not a filterable column of this entity is DROPPED rather than refused, and is simply missing here — so an empty object next to a query string that had a filter in it means the filter was misspelled, and is the only way to tell that from a filter that matched nothing.
open class FormSubmissionListFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case form_id = "form_id"
        case form_slug = "form_slug"
        case id = "id"
        case source = "source"
        case status = "status"
        case updated_at = "updated_at"
        case data
    }

    /// The `created_at` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let created_at: String?
    /// The `form_id` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let form_id: String?
    /// The `form_slug` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let form_slug: String?
    /// The `id` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let id: String?
    /// The `source` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let source: String?
    /// The `status` filter, verbatim as the query string carried it. A string here whatever the column's own type — and NOT necessarily one of the permitted values: `?status=zzz` is echoed back unchanged and matches nothing, which is the point of the echo.
    public let status: String?
    /// The `updated_at` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        created_at: String?,
        form_id: String?,
        form_slug: String?,
        id: String?,
        source: String?,
        status: String?,
        updated_at: String?,
        data: T
    ) {
        self.created_at = created_at
        self.form_id = form_id
        self.form_slug = form_slug
        self.id = id
        self.source = source
        self.status = status
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.form_id = try container.decodeIfPresent(String.self, forKey: .form_id)
        self.form_slug = try container.decodeIfPresent(String.self, forKey: .form_slug)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(form_id, forKey: .form_id)
        try container.encodeIfPresent(form_slug, forKey: .form_slug)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "form_id": form_id as Any,
            "form_slug": form_slug as Any,
            "id": id as Any,
            "source": source as Any,
            "status": status as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormSubmissionListFilter {
        return FormSubmissionListFilter(
            created_at: map["created_at"] as? String,
            form_id: map["form_id"] as? String,
            form_slug: map["form_slug"] as? String,
            id: map["id"] as? String,
            source: map["source"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
