import Foundation
import JSONCodable

/// 
open class Organization: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case external_team_id = "external_team_id"
        case id = "id"
        case name = "name"
        case settings = "settings"
        case status = "status"
        case updated_at = "updated_at"
        case vat_id = "vat_id"
    }

    /// 
    public let created_at: String?
    /// 
    public let external_team_id: String?
    /// 
    public let id: String?
    /// 
    public let name: String?
    /// 
    public let settings: [String: AnyCodable]?
    /// 
    public let status: String?
    /// 
    public let updated_at: String?
    /// 
    public let vat_id: String?

    init(
        created_at: String?,
        external_team_id: String?,
        id: String?,
        name: String?,
        settings: [String: AnyCodable]?,
        status: String?,
        updated_at: String?,
        vat_id: String?
    ) {
        self.created_at = created_at
        self.external_team_id = external_team_id
        self.id = id
        self.name = name
        self.settings = settings
        self.status = status
        self.updated_at = updated_at
        self.vat_id = vat_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.external_team_id = try container.decodeIfPresent(String.self, forKey: .external_team_id)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.settings = try container.decodeIfPresent([String: AnyCodable].self, forKey: .settings)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        self.vat_id = try container.decodeIfPresent(String.self, forKey: .vat_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(external_team_id, forKey: .external_team_id)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(settings, forKey: .settings)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
        try container.encodeIfPresent(vat_id, forKey: .vat_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "external_team_id": external_team_id as Any,
            "id": id as Any,
            "name": name as Any,
            "settings": settings as Any,
            "status": status as Any,
            "updated_at": updated_at as Any,
            "vat_id": vat_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Organization {
        return Organization(
            created_at: map["created_at"] as? String,
            external_team_id: map["external_team_id"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            settings: map["settings"] as? [String: AnyCodable],
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String,
            vat_id: map["vat_id"] as? String
        )
    }
}
