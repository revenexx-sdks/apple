import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `categories` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class CategoriesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case labels = "labels"
        case parent_id = "parent_id"
        case path = "path"
        case position = "position"
        case rule_match = "rule_match"
        case rules = "rules"
        case rules_computed_at = "rules_computed_at"
        case updated_at = "updated_at"
        case values = "values"
        case data
    }

    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?parent_id=` value this call was understood to carry.
    public let parent_id: String?
    /// The literal `?path=` value this call was understood to carry.
    public let path: String?
    /// The literal `?position=` value this call was understood to carry.
    public let position: String?
    /// The literal `?rule_match=` value this call was understood to carry.
    public let rule_match: String?
    /// The literal `?rules=` value this call was understood to carry.
    public let rules: String?
    /// The literal `?rules_computed_at=` value this call was understood to carry.
    public let rules_computed_at: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// The literal `?values=` value this call was understood to carry.
    public let values: String?
    /// Additional properties
    public let data: T

    init(
        code: String?,
        created_at: String?,
        id: String?,
        labels: String?,
        parent_id: String?,
        path: String?,
        position: String?,
        rule_match: String?,
        rules: String?,
        rules_computed_at: String?,
        updated_at: String?,
        values: String?,
        data: T
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.labels = labels
        self.parent_id = parent_id
        self.path = path
        self.position = position
        self.rule_match = rule_match
        self.rules = rules
        self.rules_computed_at = rules_computed_at
        self.updated_at = updated_at
        self.values = values
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.parent_id = try container.decodeIfPresent(String.self, forKey: .parent_id)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.rule_match = try container.decodeIfPresent(String.self, forKey: .rule_match)
        self.rules = try container.decodeIfPresent(String.self, forKey: .rules)
        self.rules_computed_at = try container.decodeIfPresent(String.self, forKey: .rules_computed_at)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.values = try container.decodeIfPresent(String.self, forKey: .values)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(parent_id, forKey: .parent_id)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(rule_match, forKey: .rule_match)
        try container.encodeIfPresent(rules, forKey: .rules)
        try container.encodeIfPresent(rules_computed_at, forKey: .rules_computed_at)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(values, forKey: .values)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "labels": labels as Any,
            "parent_id": parent_id as Any,
            "path": path as Any,
            "position": position as Any,
            "rule_match": rule_match as Any,
            "rules": rules as Any,
            "rules_computed_at": rules_computed_at as Any,
            "updated_at": updated_at as Any,
            "values": values as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> CategoriesFilter {
        return CategoriesFilter(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? String,
            parent_id: map["parent_id"] as? String,
            path: map["path"] as? String,
            position: map["position"] as? String,
            rule_match: map["rule_match"] as? String,
            rules: map["rules"] as? String,
            rules_computed_at: map["rules_computed_at"] as? String,
            updated_at: map["updated_at"] as? String,
            values: map["values"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
