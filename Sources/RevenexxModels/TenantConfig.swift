import Foundation
import JSONCodable

/// 
open class TenantConfig: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case default_locale = "default_locale"
        case defaults = "defaults"
        case delivery_reporting = "delivery_reporting"
        case locales = "locales"
        case product = "product"
        case provisioned_at = "provisioned_at"
        case quiet_hours = "quiet_hours"
        case quotas = "quotas"
        case retention_days = "retention_days"
        case support_email = "support_email"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// 
    public let created_at: String
    /// 
    public let default_locale: String
    /// 
    public let defaults: [AnyCodable]
    /// 
    public let delivery_reporting: [AnyCodable]
    /// 
    public let locales: [AnyCodable]
    /// 
    public let product: String
    /// 
    public let provisioned_at: String
    /// 
    public let quiet_hours: [AnyCodable]
    /// 
    public let quotas: [AnyCodable]
    /// 
    public let retention_days: Int
    /// 
    public let support_email: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String

    init(
        created_at: String,
        default_locale: String,
        defaults: [AnyCodable],
        delivery_reporting: [AnyCodable],
        locales: [AnyCodable],
        product: String,
        provisioned_at: String,
        quiet_hours: [AnyCodable],
        quotas: [AnyCodable],
        retention_days: Int,
        support_email: String,
        tenant_id: String,
        updated_at: String
    ) {
        self.created_at = created_at
        self.default_locale = default_locale
        self.defaults = defaults
        self.delivery_reporting = delivery_reporting
        self.locales = locales
        self.product = product
        self.provisioned_at = provisioned_at
        self.quiet_hours = quiet_hours
        self.quotas = quotas
        self.retention_days = retention_days
        self.support_email = support_email
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.default_locale = try container.decode(String.self, forKey: .default_locale)
        self.defaults = try container.decode([AnyCodable].self, forKey: .defaults)
        self.delivery_reporting = try container.decode([AnyCodable].self, forKey: .delivery_reporting)
        self.locales = try container.decode([AnyCodable].self, forKey: .locales)
        self.product = try container.decode(String.self, forKey: .product)
        self.provisioned_at = try container.decode(String.self, forKey: .provisioned_at)
        self.quiet_hours = try container.decode([AnyCodable].self, forKey: .quiet_hours)
        self.quotas = try container.decode([AnyCodable].self, forKey: .quotas)
        self.retention_days = try container.decode(Int.self, forKey: .retention_days)
        self.support_email = try container.decode(String.self, forKey: .support_email)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(created_at, forKey: .created_at)
        try container.encode(default_locale, forKey: .default_locale)
        try container.encode(defaults, forKey: .defaults)
        try container.encode(delivery_reporting, forKey: .delivery_reporting)
        try container.encode(locales, forKey: .locales)
        try container.encode(product, forKey: .product)
        try container.encode(provisioned_at, forKey: .provisioned_at)
        try container.encode(quiet_hours, forKey: .quiet_hours)
        try container.encode(quotas, forKey: .quotas)
        try container.encode(retention_days, forKey: .retention_days)
        try container.encode(support_email, forKey: .support_email)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "default_locale": default_locale as Any,
            "defaults": defaults as Any,
            "delivery_reporting": delivery_reporting as Any,
            "locales": locales as Any,
            "product": product as Any,
            "provisioned_at": provisioned_at as Any,
            "quiet_hours": quiet_hours as Any,
            "quotas": quotas as Any,
            "retention_days": retention_days as Any,
            "support_email": support_email as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TenantConfig {
        return TenantConfig(
            created_at: map["created_at"] as! String,
            default_locale: map["default_locale"] as! String,
            defaults: (map["defaults"] as! [Any]).map { AnyCodable($0) },
            delivery_reporting: (map["delivery_reporting"] as! [Any]).map { AnyCodable($0) },
            locales: (map["locales"] as! [Any]).map { AnyCodable($0) },
            product: map["product"] as! String,
            provisioned_at: map["provisioned_at"] as! String,
            quiet_hours: (map["quiet_hours"] as! [Any]).map { AnyCodable($0) },
            quotas: (map["quotas"] as! [Any]).map { AnyCodable($0) },
            retention_days: map["retention_days"] as! Int,
            support_email: map["support_email"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String
        )
    }
}
