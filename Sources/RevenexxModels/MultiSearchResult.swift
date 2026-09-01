import Foundation
import JSONCodable

/// 
open class MultiSearchResult<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case results = "results"
    }

    /// One result per entry in `searches`, in the same order.
    public let results: [SearchResult<T>]

    init(
        results: [SearchResult<T>]
    ) {
        self.results = results
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.results = try container.decode([SearchResult<T>].self, forKey: .results)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(results, forKey: .results)
    }

    public func toMap() -> [String: Any] {
        return [
            "results": results.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MultiSearchResult {
        return MultiSearchResult(
            results: (map["results"] as! [[String: Any]]).map { SearchResult.from(map: $0) }
        )
    }
}
