import Foundation
import JSONCodable

/// Subscriber list
open class SubscriberList: Codable {

    enum CodingKeys: String, CodingKey {
        case subscribers = "subscribers"
        case total = "total"
    }

    /// List of subscribers.
    public let subscribers: [Subscriber]
    /// Total number of subscribers that matched your query.
    public let total: Int

    init(
        subscribers: [Subscriber],
        total: Int
    ) {
        self.subscribers = subscribers
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.subscribers = try container.decode([Subscriber].self, forKey: .subscribers)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(subscribers, forKey: .subscribers)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "subscribers": subscribers.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SubscriberList {
        return SubscriberList(
            subscribers: (map["subscribers"] as! [[String: Any]]).map { Subscriber.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
