import Foundation
import JSONCodable

/// 
open class AssociationTypes: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_quantified = "is_quantified"
        case is_two_way = "is_two_way"
        case labels = "labels"
    }

    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let is_quantified: Bool?
    /// 
    public let is_two_way: Bool?
    /// 
    public let labels: [String: AnyCodable]?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_quantified: Bool?,
        is_two_way: Bool?,
        labels: [String: AnyCodable]?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_quantified = is_quantified
        self.is_two_way = is_two_way
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_quantified = try container.decodeIfPresent(Bool.self, forKey: .is_quantified)
        self.is_two_way = try container.decodeIfPresent(Bool.self, forKey: .is_two_way)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_quantified, forKey: .is_quantified)
        try container.encodeIfPresent(is_two_way, forKey: .is_two_way)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_quantified": is_quantified as Any,
            "is_two_way": is_two_way as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AssociationTypes {
        return AssociationTypes(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_quantified: map["is_quantified"] as? Bool,
            is_two_way: map["is_two_way"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
