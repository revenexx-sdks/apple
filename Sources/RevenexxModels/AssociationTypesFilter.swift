import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `association_types` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class AssociationTypesFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_quantified = "is_quantified"
        case is_two_way = "is_two_way"
        case labels = "labels"
        case data
    }

    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?is_quantified=` value this call was understood to carry.
    public let is_quantified: String?
    /// The literal `?is_two_way=` value this call was understood to carry.
    public let is_two_way: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// Additional properties
    public let data: T

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_quantified: String?,
        is_two_way: String?,
        labels: String?,
        data: T
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_quantified = is_quantified
        self.is_two_way = is_two_way
        self.labels = labels
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_quantified = try container.decodeIfPresent(String.self, forKey: .is_quantified)
        self.is_two_way = try container.decodeIfPresent(String.self, forKey: .is_two_way)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_quantified, forKey: .is_quantified)
        try container.encodeIfPresent(is_two_way, forKey: .is_two_way)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_quantified": is_quantified as Any,
            "is_two_way": is_two_way as Any,
            "labels": labels as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> AssociationTypesFilter {
        return AssociationTypesFilter(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_quantified: map["is_quantified"] as? String,
            is_two_way: map["is_two_way"] as? String,
            labels: map["labels"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
