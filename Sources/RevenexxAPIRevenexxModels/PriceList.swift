import Foundation
import JSONCodable

/// 
open class PriceList: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case code = "code"
        case contact_id = "contact_id"
        case created_at = "created_at"
        case currency = "currency"
        case description = "description"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case market_id = "market_id"
        case metadata = "metadata"
        case name = "name"
        case organization_id = "organization_id"
        case priority = "priority"
        case status = "status"
        case tax_included = "tax_included"
        case updated_at = "updated_at"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
    }

    /// 
    public let channel_id: String?
    /// 
    public let code: String?
    /// 
    public let contact_id: String?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let description: String?
    /// 
    public let id: String?
    /// 
    public let is_default: Bool?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let market_id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let organization_id: String?
    /// 
    public let priority: Int?
    /// 
    public let status: String?
    /// 
    public let tax_included: Bool?
    /// 
    public let updated_at: String?
    /// 
    public let valid_from: String?
    /// 
    public let valid_until: String?

    init(
        channel_id: String?,
        code: String?,
        contact_id: String?,
        created_at: String?,
        currency: String?,
        description: String?,
        id: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        market_id: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        organization_id: String?,
        priority: Int?,
        status: String?,
        tax_included: Bool?,
        updated_at: String?,
        valid_from: String?,
        valid_until: String?
    ) {
        self.channel_id = channel_id
        self.code = code
        self.contact_id = contact_id
        self.created_at = created_at
        self.currency = currency
        self.description = description
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.market_id = market_id
        self.metadata = metadata
        self.name = name
        self.organization_id = organization_id
        self.priority = priority
        self.status = status
        self.tax_included = tax_included
        self.updated_at = updated_at
        self.valid_from = valid_from
        self.valid_until = valid_until
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.contact_id = try container.decodeIfPresent(String.self, forKey: .contact_id)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.tax_included = try container.decodeIfPresent(Bool.self, forKey: .tax_included)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.valid_from = try container.decodeIfPresent(String.self, forKey: .valid_from)
        self.valid_until = try container.decodeIfPresent(String.self, forKey: .valid_until)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(contact_id, forKey: .contact_id)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(tax_included, forKey: .tax_included)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(valid_from, forKey: .valid_from)
        try container.encodeIfPresent(valid_until, forKey: .valid_until)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "code": code as Any,
            "contact_id": contact_id as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "description": description as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "market_id": market_id as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "organization_id": organization_id as Any,
            "priority": priority as Any,
            "status": status as Any,
            "tax_included": tax_included as Any,
            "updated_at": updated_at as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceList {
        return PriceList(
            channel_id: map["channel_id"] as? String,
            code: map["code"] as? String,
            contact_id: map["contact_id"] as? String,
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            market_id: map["market_id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            organization_id: map["organization_id"] as? String,
            priority: map["priority"] as? Int,
            status: map["status"] as? String,
            tax_included: map["tax_included"] as? Bool,
            updated_at: map["updated_at"] as? String,
            valid_from: map["valid_from"] as? String,
            valid_until: map["valid_until"] as? String
        )
    }
}
