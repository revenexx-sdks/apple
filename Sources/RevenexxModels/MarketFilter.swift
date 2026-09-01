import Foundation
import JSONCodable

/// The exact-column filters this call applied, echoed back. Every value is the raw query string, never the column's own type: `?is_default=true` comes back as `"true"`. A `?column=value` naming a column this entity does not have is DROPPED rather than refused — the call answers 200 with the unfiltered list, and the key missing from here is the only way to find out.
open class MarketFilter: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case currency = "currency"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
        case updated_at = "updated_at"
    }

    /// The `code` filter as it arrived, verbatim. Present only when the call sent it.
    public let code: String?
    /// The `created_at` filter as it arrived, verbatim. Present only when the call sent it. Any form the database accepts as a timestamp, including a bare date.
    public let created_at: String?
    /// The `currency` filter as it arrived, verbatim. Present only when the call sent it.
    public let currency: String?
    /// The `id` filter as it arrived, verbatim. Present only when the call sent it.
    public let id: String?
    /// The `is_default` filter as it arrived, verbatim. Present only when the call sent it.
    public let is_default: String?
    /// The `labels` filter as it arrived, verbatim. Present only when the call sent it.
    public let labels: String?
    /// The `name` filter as it arrived, verbatim. Present only when the call sent it.
    public let name: String?
    /// The `position` filter as it arrived, verbatim. Present only when the call sent it.
    public let position: String?
    /// The `status` filter as it arrived, verbatim. Present only when the call sent it.
    public let status: String?
    /// The `updated_at` filter as it arrived, verbatim. Present only when the call sent it. Any form the database accepts as a timestamp, including a bare date.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        currency: String?,
        id: String?,
        is_default: String?,
        labels: String?,
        name: String?,
        position: String?,
        status: String?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.currency = currency
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(String.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent(String.self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(String.self, forKey: .position)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketFilter {
        return MarketFilter(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? String,
            labels: map["labels"] as? String,
            name: map["name"] as? String,
            position: map["position"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
