import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class OrganizationCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case settings = "settings"
        case status = "status"
        case vat_id = "vat_id"
    }

    /// Company name — mirrored to the platform team.
    public let name: String
    /// Free-form organization settings.
    public let settings: [String: AnyCodable]?
    /// Default &#039;active&#039;.
    public let status: Revenexx API — revenexxEnums.OrganizationStatus?
    /// 
    public let vat_id: String?

    init(
        name: String,
        settings: [String: AnyCodable]?,
        status: Revenexx API — revenexxEnums.OrganizationStatus?,
        vat_id: String?
    ) {
        self.name = name
        self.settings = settings
        self.status = status
        self.vat_id = vat_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.settings = try container.decodeIfPresent([String: AnyCodable].self, forKey: .settings)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = Revenexx API — revenexxEnums.OrganizationStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.vat_id = try container.decodeIfPresent(String.self, forKey: .vat_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(settings, forKey: .settings)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(vat_id, forKey: .vat_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "name": name as Any,
            "settings": settings as Any,
            "status": status?.rawValue as Any,
            "vat_id": vat_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationCreateRequest {
        return OrganizationCreateRequest(
            name: map["name"] as! String,
            settings: map["settings"] as? [String: AnyCodable],
            status: map["status"] as? String != nil ? OrganizationStatus(rawValue: map["status"] as! String) : nil,
            vat_id: map["vat_id"] as? String
        )
    }
}
