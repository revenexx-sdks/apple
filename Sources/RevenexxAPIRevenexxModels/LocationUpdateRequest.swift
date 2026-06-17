import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// Partial update — omitted fields keep their current value.
open class LocationUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case code = "code"
        case enabled = "enabled"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case priority = "priority"
        case type = "type"
    }

    /// 
    public let address: [String: AnyCodable]?
    /// Unique location code (per tenant).
    public let code: String?
    /// Disabled locations are skipped by availability and reserve (default true).
    public let enabled: Bool?
    /// Localised display names ({de, en, …}).
    public let labels: [String: AnyCodable]?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// Sourcing order — lower wins (default 0).
    public let priority: Int?
    /// Default &#039;warehouse&#039;.
    public let type: Revenexx API — revenexxEnums.LocationType?

    init(
        address: [String: AnyCodable]?,
        code: String?,
        enabled: Bool?,
        labels: [String: AnyCodable]?,
        metadata: [String: AnyCodable]?,
        name: String?,
        priority: Int?,
        type: Revenexx API — revenexxEnums.LocationType?
    ) {
        self.address = address
        self.code = code
        self.enabled = enabled
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.priority = priority
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .address)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = Revenexx API — revenexxEnums.LocationType(rawValue: typeString)
        } else {
            self.type = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "address": address as Any,
            "code": code as Any,
            "enabled": enabled as Any,
            "labels": labels as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "priority": priority as Any,
            "type": type?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LocationUpdateRequest {
        return LocationUpdateRequest(
            address: map["address"] as? [String: AnyCodable],
            code: map["code"] as? String,
            enabled: map["enabled"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            priority: map["priority"] as? Int,
            type: map["type"] as? String != nil ? LocationType(rawValue: map["type"] as! String) : nil
        )
    }
}
