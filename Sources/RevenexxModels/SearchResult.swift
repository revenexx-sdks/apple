import Foundation
import JSONCodable

/// A Typesense search response, passed through verbatim.
open class SearchResult<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case facet_counts = "facet_counts"
        case found = "found"
        case hits = "hits"
        case out_of = "out_of"
        case page = "page"
        case search_time_ms = "search_time_ms"
        case data
    }

    /// 
    public let facet_counts: [FacetCount<T>]?
    /// Total matching documents.
    public let found: Int?
    /// 
    public let hits: [SearchHit<T>]?
    /// Documents searched.
    public let out_of: Int?
    /// 1-based page this result is for.
    public let page: Int?
    /// 
    public let search_time_ms: Int?
    /// Additional properties
    public let data: T

    init(
        facet_counts: [FacetCount<T>]?,
        found: Int?,
        hits: [SearchHit<T>]?,
        out_of: Int?,
        page: Int?,
        search_time_ms: Int?,
        data: T
    ) {
        self.facet_counts = facet_counts
        self.found = found
        self.hits = hits
        self.out_of = out_of
        self.page = page
        self.search_time_ms = search_time_ms
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.facet_counts = try container.decodeIfPresent([FacetCount<T>].self, forKey: .facet_counts)
        self.found = try container.decodeIfPresent(Int.self, forKey: .found)
        self.hits = try container.decodeIfPresent([SearchHit<T>].self, forKey: .hits)
        self.out_of = try container.decodeIfPresent(Int.self, forKey: .out_of)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.search_time_ms = try container.decodeIfPresent(Int.self, forKey: .search_time_ms)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(facet_counts, forKey: .facet_counts)
        try container.encodeIfPresent(found, forKey: .found)
        try container.encodeIfPresent(hits, forKey: .hits)
        try container.encodeIfPresent(out_of, forKey: .out_of)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(search_time_ms, forKey: .search_time_ms)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "facet_counts": facet_counts?.map { $0.toMap() } as Any,
            "found": found as Any,
            "hits": hits?.map { $0.toMap() } as Any,
            "out_of": out_of as Any,
            "page": page as Any,
            "search_time_ms": search_time_ms as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> SearchResult {
        return SearchResult(
            facet_counts: (map["facet_counts"] as? [[String: Any]] ?? []).map { FacetCount.from(map: $0) },
            found: map["found"] as? Int,
            hits: (map["hits"] as? [[String: Any]] ?? []).map { SearchHit.from(map: $0) },
            out_of: map["out_of"] as? Int,
            page: map["page"] as? Int,
            search_time_ms: map["search_time_ms"] as? Int,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
