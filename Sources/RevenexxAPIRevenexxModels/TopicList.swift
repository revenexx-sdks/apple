import Foundation
import JSONCodable

/// Topic list
open class TopicList: Codable {

    enum CodingKeys: String, CodingKey {
        case topics = "topics"
        case total = "total"
    }

    /// List of topics.
    public let topics: [Topic]
    /// Total number of topics that matched your query.
    public let total: Int

    init(
        topics: [Topic],
        total: Int
    ) {
        self.topics = topics
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.topics = try container.decode([Topic].self, forKey: .topics)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(topics, forKey: .topics)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "topics": topics.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TopicList {
        return TopicList(
            topics: (map["topics"] as! [[String: Any]]).map { Topic.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
