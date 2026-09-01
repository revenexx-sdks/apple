import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, echoed with the values as they arrived. A query parameter that is not a filterable column of this entity is DROPPED rather than refused, and is simply missing here — so an empty object next to a query string that had a filter in it means the filter was misspelled, and is the only way to tell that from a filter that matched nothing.
open class FormListFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case name = "name"
        case slug = "slug"
        case status = "status"
        case updated_at = "updated_at"
        case data
    }

    /// The `created_at` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let created_at: String?
    /// The `id` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let id: String?
    /// The `name` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let name: String?
    /// The `slug` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let slug: String?
    /// The `status` filter, verbatim as the query string carried it. A string here whatever the column's own type — and NOT necessarily one of the permitted values: `?status=zzz` is echoed back unchanged and matches nothing, which is the point of the echo.
    public let status: String?
    /// The `updated_at` filter, verbatim as the query string carried it. A string here whatever the column's own type.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        created_at: String?,
        id: String?,
        name: String?,
        slug: String?,
        status: String?,
        updated_at: String?,
        data: T
    ) {
        self.created_at = created_at
        self.id = id
        self.name = name
        self.slug = slug
        self.status = status
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(slug, forKey: .slug)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "name": name as Any,
            "slug": slug as Any,
            "status": status as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormListFilter {
        return FormListFilter(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            slug: map["slug"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
