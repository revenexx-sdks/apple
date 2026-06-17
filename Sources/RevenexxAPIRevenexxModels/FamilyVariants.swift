import Foundation
import JSONCodable

/// 
open class FamilyVariants: Codable {

    enum CodingKeys: String, CodingKey {
        case axes = "axes"
        case code = "code"
        case created_at = "created_at"
        case family_id = "family_id"
        case id = "id"
        case labels = "labels"
        case updated_at = "updated_at"
    }

    /// 
    public let axes: [String: AnyCodable]?
    /// 
    public let code: String?
    /// 
    public let created_at: String?
    /// 
    public let family_id: String?
    /// 
    public let id: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let updated_at: String?

    init(
        axes: [String: AnyCodable]?,
        code: String?,
        created_at: String?,
        family_id: String?,
        id: String?,
        labels: [String: AnyCodable]?,
        updated_at: String?
    ) {
        self.axes = axes
        self.code = code
        self.created_at = created_at
        self.family_id = family_id
        self.id = id
        self.labels = labels
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.axes = try container.decodeIfPresent([String: AnyCodable].self, forKey: .axes)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(axes, forKey: .axes)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(family_id, forKey: .family_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "axes": axes as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "family_id": family_id as Any,
            "id": id as Any,
            "labels": labels as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyVariants {
        return FamilyVariants(
            axes: map["axes"] as? [String: AnyCodable],
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            family_id: map["family_id"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            updated_at: map["updated_at"] as? String
        )
    }
}
