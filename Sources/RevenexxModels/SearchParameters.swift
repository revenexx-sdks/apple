import Foundation
import JSONCodable

/// Typesense search parameters. Only the commonly used ones are enumerated — the proxy forwards the whole object, so any parameter Typesense accepts may be sent.
open class SearchParameters<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case exclude_fields = "exclude_fields"
        case facet_by = "facet_by"
        case filter_by = "filter_by"
        case group_by = "group_by"
        case highlight_full_fields = "highlight_full_fields"
        case include_fields = "include_fields"
        case max_facet_values = "max_facet_values"
        case num_typos = "num_typos"
        case page = "page"
        case per_page = "per_page"
        case `prefix` = "prefix"
        case q = "q"
        case query_by = "query_by"
        case sort_by = "sort_by"
        case data
    }

    /// Comma-separated document fields to omit.
    public let exclude_fields: String?
    /// Comma-separated fields to facet on.
    public let facet_by: String?
    /// Filter expression, e.g. `in_stock:=true && price:<100`. ANDed with the tenant filter the proxy injects.
    public let filter_by: String?
    /// Comma-separated fields to group results by.
    public let group_by: String?
    /// Comma-separated fields to highlight in full.
    public let highlight_full_fields: String?
    /// Comma-separated document fields to return.
    public let include_fields: String?
    /// Facet values to return per field.
    public let max_facet_values: Int?
    /// Typos tolerated per query token.
    public let num_typos: Int?
    /// 1-based page number.
    public let page: Int?
    /// Hits per page.
    public let per_page: Int?
    /// Whether the last token is a prefix; per-field when comma-separated.
    public let `prefix`: String?
    /// Query text. Use `*` to match everything.
    public let q: String?
    /// Comma-separated fields to search, in weight order.
    public let query_by: String?
    /// Sort expression, e.g. `price:desc`.
    public let sort_by: String?
    /// Additional properties
    public let data: T

    init(
        exclude_fields: String?,
        facet_by: String?,
        filter_by: String?,
        group_by: String?,
        highlight_full_fields: String?,
        include_fields: String?,
        max_facet_values: Int?,
        num_typos: Int?,
        page: Int?,
        per_page: Int?,
        `prefix`: String?,
        q: String?,
        query_by: String?,
        sort_by: String?,
        data: T
    ) {
        self.exclude_fields = exclude_fields
        self.facet_by = facet_by
        self.filter_by = filter_by
        self.group_by = group_by
        self.highlight_full_fields = highlight_full_fields
        self.include_fields = include_fields
        self.max_facet_values = max_facet_values
        self.num_typos = num_typos
        self.page = page
        self.per_page = per_page
        self.`prefix` = `prefix`
        self.q = q
        self.query_by = query_by
        self.sort_by = sort_by
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.exclude_fields = try container.decodeIfPresent(String.self, forKey: .exclude_fields)
        self.facet_by = try container.decodeIfPresent(String.self, forKey: .facet_by)
        self.filter_by = try container.decodeIfPresent(String.self, forKey: .filter_by)
        self.group_by = try container.decodeIfPresent(String.self, forKey: .group_by)
        self.highlight_full_fields = try container.decodeIfPresent(String.self, forKey: .highlight_full_fields)
        self.include_fields = try container.decodeIfPresent(String.self, forKey: .include_fields)
        self.max_facet_values = try container.decodeIfPresent(Int.self, forKey: .max_facet_values)
        self.num_typos = try container.decodeIfPresent(Int.self, forKey: .num_typos)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.per_page = try container.decodeIfPresent(Int.self, forKey: .per_page)
        self.`prefix` = try container.decodeIfPresent(String.self, forKey: .`prefix`)
        self.q = try container.decodeIfPresent(String.self, forKey: .q)
        self.query_by = try container.decodeIfPresent(String.self, forKey: .query_by)
        self.sort_by = try container.decodeIfPresent(String.self, forKey: .sort_by)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(exclude_fields, forKey: .exclude_fields)
        try container.encodeIfPresent(facet_by, forKey: .facet_by)
        try container.encodeIfPresent(filter_by, forKey: .filter_by)
        try container.encodeIfPresent(group_by, forKey: .group_by)
        try container.encodeIfPresent(highlight_full_fields, forKey: .highlight_full_fields)
        try container.encodeIfPresent(include_fields, forKey: .include_fields)
        try container.encodeIfPresent(max_facet_values, forKey: .max_facet_values)
        try container.encodeIfPresent(num_typos, forKey: .num_typos)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(per_page, forKey: .per_page)
        try container.encodeIfPresent(`prefix`, forKey: .`prefix`)
        try container.encodeIfPresent(q, forKey: .q)
        try container.encodeIfPresent(query_by, forKey: .query_by)
        try container.encodeIfPresent(sort_by, forKey: .sort_by)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "exclude_fields": exclude_fields as Any,
            "facet_by": facet_by as Any,
            "filter_by": filter_by as Any,
            "group_by": group_by as Any,
            "highlight_full_fields": highlight_full_fields as Any,
            "include_fields": include_fields as Any,
            "max_facet_values": max_facet_values as Any,
            "num_typos": num_typos as Any,
            "page": page as Any,
            "per_page": per_page as Any,
            "prefix": `prefix` as Any,
            "q": q as Any,
            "query_by": query_by as Any,
            "sort_by": sort_by as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> SearchParameters {
        return SearchParameters(
            exclude_fields: map["exclude_fields"] as? String,
            facet_by: map["facet_by"] as? String,
            filter_by: map["filter_by"] as? String,
            group_by: map["group_by"] as? String,
            highlight_full_fields: map["highlight_full_fields"] as? String,
            include_fields: map["include_fields"] as? String,
            max_facet_values: map["max_facet_values"] as? Int,
            num_typos: map["num_typos"] as? Int,
            page: map["page"] as? Int,
            per_page: map["per_page"] as? Int,
            prefix: map["prefix"] as? String,
            q: map["q"] as? String,
            query_by: map["query_by"] as? String,
            sort_by: map["sort_by"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
