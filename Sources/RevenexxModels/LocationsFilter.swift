import Foundation
import JSONCodable

/// The exact-column filters this call was understood to carry, verbatim as they arrived. A query parameter that is not a column of `locations` — a typo, a filter another entity has, `?q=` — is DROPPED and cannot appear here, and the list comes back unfiltered. This object is the only way to tell that apart from "nothing matched".
open class LocationsFilter<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case code = "code"
        case created_at = "created_at"
        case enabled = "enabled"
        case id = "id"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case priority = "priority"
        case type = "type"
        case updated_at = "updated_at"
        case data
    }

    /// The literal `?address=` value this call was understood to carry.
    public let address: String?
    /// The literal `?code=` value this call was understood to carry.
    public let code: String?
    /// The literal `?created_at=` value this call was understood to carry.
    public let created_at: String?
    /// The literal `?enabled=` value this call was understood to carry.
    public let enabled: String?
    /// The literal `?id=` value this call was understood to carry.
    public let id: String?
    /// The literal `?labels=` value this call was understood to carry.
    public let labels: String?
    /// The literal `?metadata=` value this call was understood to carry.
    public let metadata: String?
    /// The literal `?name=` value this call was understood to carry.
    public let name: String?
    /// The literal `?priority=` value this call was understood to carry.
    public let priority: String?
    /// The literal `?type=` value this call was understood to carry.
    public let type: String?
    /// The literal `?updated_at=` value this call was understood to carry.
    public let updated_at: String?
    /// Additional properties
    public let data: T

    init(
        address: String?,
        code: String?,
        created_at: String?,
        enabled: String?,
        id: String?,
        labels: String?,
        metadata: String?,
        name: String?,
        priority: String?,
        type: String?,
        updated_at: String?,
        data: T
    ) {
        self.address = address
        self.code = code
        self.created_at = created_at
        self.enabled = enabled
        self.id = id
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.priority = priority
        self.type = type
        self.updated_at = updated_at
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.enabled = try container.decodeIfPresent(String.self, forKey: .enabled)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.metadata = try container.decodeIfPresent(String.self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.priority = try container.decodeIfPresent(String.self, forKey: .priority)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "address": address as Any,
            "code": code as Any,
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "id": id as Any,
            "labels": labels as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "priority": priority as Any,
            "type": type as Any,
            "updated_at": updated_at as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> LocationsFilter {
        return LocationsFilter(
            address: map["address"] as? String,
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            enabled: map["enabled"] as? String,
            id: map["id"] as? String,
            labels: map["labels"] as? String,
            metadata: map["metadata"] as? String,
            name: map["name"] as? String,
            priority: map["priority"] as? String,
            type: map["type"] as? String,
            updated_at: map["updated_at"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
