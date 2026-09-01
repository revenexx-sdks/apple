import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `family_variants` — `?status=`, a typo, a filter another entity has — is DROPPED and does not appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class FamilyVariantsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case axes = "axes"
        case code = "code"
        case created_at = "created_at"
        case family_id = "family_id"
        case id = "id"
        case labels = "labels"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?axes=` value this call was understood to carry.
    public let axes: String?
    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?family_id=` value this call was understood to carry.
    public let family_id: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        axes: String?,
        code: String?,
        created_at: String?,
        family_id: String?,
        id: String?,
        labels: String?,
        updated_at: String?,
        data: T
    ) {
        self.axes = axes
        self.code = code
        self.created_at = created_at
        self.family_id = family_id
        self.id = id
        self.labels = labels
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.axes = try container.decodeIfPresent(String.self, forKey: .axes)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
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
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "axes": axes as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "family_id": family_id as Any,
            "id": id as Any,
            "labels": labels as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyVariantsFilter {
        return FamilyVariantsFilter(
            axes: map["axes"] as? String,
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            family_id: map["family_id"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
