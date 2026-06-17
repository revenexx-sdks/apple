import Foundation
import JSONCodable

/// Message list
open class MessageList: Codable {

    enum CodingKeys: String, CodingKey {
        case messages = "messages"
        case total = "total"
    }

    /// List of messages.
    public let messages: [Message]
    /// Total number of messages that matched your query.
    public let total: Int

    init(
        messages: [Message],
        total: Int
    ) {
        self.messages = messages
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.messages = try container.decode([Message].self, forKey: .messages)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(messages, forKey: .messages)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "messages": messages.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MessageList {
        return MessageList(
            messages: (map["messages"] as! [[String: Any]]).map { Message.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
