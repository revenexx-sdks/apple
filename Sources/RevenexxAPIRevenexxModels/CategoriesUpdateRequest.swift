import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class CategoriesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case parent_id = "parent_id"
        case path = "path"
        case position = "position"
        case values = "values"
    }

    /// 
    public let code: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let parent_id: String?
    /// 
    public let path: String?
    /// 
    public let position: Int?
    /// 
    public let values: [String: AnyCodable]?

    init(
        code: String?,
        labels: [String: AnyCodable]?,
        parent_id: String?,
        path: String?,
        position: Int?,
        values: [String: AnyCodable]?
    ) {
        self.code = code
        self.labels = labels
        self.parent_id = parent_id
        self.path = path
        self.position = position
        self.values = values
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .values)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(values, forKey: .values)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "parent_id": parent_id as Any,
            "path": path as Any,
            "position": position as Any,
            "values": values as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CategoriesUpdateRequest {
        return CategoriesUpdateRequest(
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            parent_id: map["parent_id"] as? String,
            path: map["path"] as? String,
            position: map["position"] as? Int,
            values: map["values"] as? [String: AnyCodable]
        )
    }
}
