import Foundation
import JSONCodable

/// 
open class Comment: Codable {

    enum CodingKeys: String, CodingKey {
        case author_id = "author_id"
        case author_name = "author_name"
        case block_uuids = "block_uuids"
        case body = "body"
        case created_at = "created_at"
        case id = "id"
        case page_id = "page_id"
        case parent_id = "parent_id"
        case resolved = "resolved"
        case updated_at = "updated_at"
    }

    /// 
    public let author_id: String?
    /// 
    public let author_name: String?
    /// 
    public let block_uuids: [String: AnyCodable]?
    /// 
    public let body: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let page_id: String?
    /// 
    public let parent_id: String?
    /// 
    public let resolved: Bool?
    /// 
    public let updated_at: String?

    init(
        author_id: String?,
        author_name: String?,
        block_uuids: [String: AnyCodable]?,
        body: String?,
        created_at: String?,
        id: String?,
        page_id: String?,
        parent_id: String?,
        resolved: Bool?,
        updated_at: String?
    ) {
        self.author_id = author_id
        self.author_name = author_name
        self.block_uuids = block_uuids
        self.body = body
        self.created_at = created_at
        self.id = id
        self.page_id = page_id
        self.parent_id = parent_id
        self.resolved = resolved
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.author_id = try container.decodeIfPresent(String.self, forKey: .author_id)
        self.author_name = try container.decodeIfPresent(String.self, forKey: .author_name)
        self.block_uuids = try container.decodeIfPresent([String: AnyCodable].self, forKey: .block_uuids)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.page_id = try container.decodeIfPresent(String.self, forKey: .page_id)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.resolved = try container.decodeIfPresent(Bool.self, forKey: .resolved)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(author_id, forKey: .author_id)
        try container.encodeIfPresent(author_name, forKey: .author_name)
        try container.encodeIfPresent(block_uuids, forKey: .block_uuids)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(page_id, forKey: .page_id)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "author_id": author_id as Any,
            "author_name": author_name as Any,
            "block_uuids": block_uuids as Any,
            "body": body as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "page_id": page_id as Any,
            "parent_id": parent_id as Any,
            "resolved": resolved as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Comment {
        return Comment(
            author_id: map["author_id"] as? String,
            author_name: map["author_name"] as? String,
            block_uuids: map["block_uuids"] as? [String: AnyCodable],
            body: map["body"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            page_id: map["page_id"] as? String,
            parent_id: map["parent_id"] as? String,
            resolved: map["resolved"] as? Bool,
            updated_at: map["updated_at"] as? String
        )
    }
}
