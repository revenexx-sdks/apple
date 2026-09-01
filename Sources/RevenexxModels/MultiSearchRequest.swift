import Foundation
import JSONCodable

/// Envelope for a federated search. Top-level search parameters outside `searches` are forwarded to Typesense unchanged and act as defaults for every entry.
open class MultiSearchRequest<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case searches = "searches"
        case data
    }

    /// The searches to run, in order. Must not be empty.
    public let searches: [MultiSearchEntry<T>]
    /// Additional properties
    public let data: T

    init(
        searches: [MultiSearchEntry<T>],
        data: T
    ) {
        self.searches = searches
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.searches = try container.decode([MultiSearchEntry<T>].self, forKey: .searches)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(searches, forKey: .searches)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "searches": searches.map { $0.toMap() } as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> MultiSearchRequest {
        return MultiSearchRequest(
            searches: (map["searches"] as! [[String: Any]]).map { MultiSearchEntry.from(map: $0) },
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
