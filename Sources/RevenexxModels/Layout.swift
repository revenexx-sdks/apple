import Foundation
import JSONCodable

/// 
open class Layout: Codable {

    enum CodingKeys: String, CodingKey {
        case color_accent = "color_accent"
        case color_bg = "color_bg"
        case color_text = "color_text"
        case created_at = "created_at"
        case enabled = "enabled"
        case font_family = "font_family"
        case footer_note = "footer_note"
        case id = "id"
        case is_default = "is_default"
        case legal_name = "legal_name"
        case lifecycle_state = "lifecycle_state"
        case logo_url = "logo_url"
        case markets = "markets"
        case menu_links = "menu_links"
        case name = "name"
        case postal_address = "postal_address"
        case sender_name = "sender_name"
        case social_links = "social_links"
        case support_email = "support_email"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
        case width = "width"
    }

    /// 
    public let color_accent: String
    /// 
    public let color_bg: String
    /// 
    public let color_text: String
    /// 
    public let created_at: String
    /// 
    public let enabled: Bool
    /// 
    public let font_family: String
    /// 
    public let footer_note: String
    /// 
    public let id: String
    /// 
    public let is_default: Bool
    /// 
    public let legal_name: String
    /// 
    public let lifecycle_state: String
    /// 
    public let logo_url: String
    /// 
    public let markets: [AnyCodable]
    /// 
    public let menu_links: [AnyCodable]
    /// 
    public let name: String
    /// 
    public let postal_address: String
    /// 
    public let sender_name: String
    /// 
    public let social_links: [AnyCodable]
    /// 
    public let support_email: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String
    /// 
    public let valid_from: String
    /// 
    public let valid_until: String
    /// 
    public let width: String

    init(
        color_accent: String,
        color_bg: String,
        color_text: String,
        created_at: String,
        enabled: Bool,
        font_family: String,
        footer_note: String,
        id: String,
        is_default: Bool,
        legal_name: String,
        lifecycle_state: String,
        logo_url: String,
        markets: [AnyCodable],
        menu_links: [AnyCodable],
        name: String,
        postal_address: String,
        sender_name: String,
        social_links: [AnyCodable],
        support_email: String,
        tenant_id: String,
        updated_at: String,
        valid_from: String,
        valid_until: String,
        width: String
    ) {
        self.color_accent = color_accent
        self.color_bg = color_bg
        self.color_text = color_text
        self.created_at = created_at
        self.enabled = enabled
        self.font_family = font_family
        self.footer_note = footer_note
        self.id = id
        self.is_default = is_default
        self.legal_name = legal_name
        self.lifecycle_state = lifecycle_state
        self.logo_url = logo_url
        self.markets = markets
        self.menu_links = menu_links
        self.name = name
        self.postal_address = postal_address
        self.sender_name = sender_name
        self.social_links = social_links
        self.support_email = support_email
        self.tenant_id = tenant_id
        self.updated_at = updated_at
        self.valid_from = valid_from
        self.valid_until = valid_until
        self.width = width
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.color_accent = try container.decode(String.self, forKey: .color_accent)
        self.color_bg = try container.decode(String.self, forKey: .color_bg)
        self.color_text = try container.decode(String.self, forKey: .color_text)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.font_family = try container.decode(String.self, forKey: .font_family)
        self.footer_note = try container.decode(String.self, forKey: .footer_note)
        self.id = try container.decode(String.self, forKey: .id)
        self.is_default = try container.decode(Bool.self, forKey: .is_default)
        self.legal_name = try container.decode(String.self, forKey: .legal_name)
        self.lifecycle_state = try container.decode(String.self, forKey: .lifecycle_state)
        self.logo_url = try container.decode(String.self, forKey: .logo_url)
        self.markets = try container.decode([AnyCodable].self, forKey: .markets)
        self.menu_links = try container.decode([AnyCodable].self, forKey: .menu_links)
        self.name = try container.decode(String.self, forKey: .name)
        self.postal_address = try container.decode(String.self, forKey: .postal_address)
        self.sender_name = try container.decode(String.self, forKey: .sender_name)
        self.social_links = try container.decode([AnyCodable].self, forKey: .social_links)
        self.support_email = try container.decode(String.self, forKey: .support_email)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.valid_from = try container.decode(String.self, forKey: .valid_from)
        self.valid_until = try container.decode(String.self, forKey: .valid_until)
        self.width = try container.decode(String.self, forKey: .width)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(color_accent, forKey: .color_accent)
        try container.encode(color_bg, forKey: .color_bg)
        try container.encode(color_text, forKey: .color_text)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(font_family, forKey: .font_family)
        try container.encode(footer_note, forKey: .footer_note)
        try container.encode(id, forKey: .id)
        try container.encode(is_default, forKey: .is_default)
        try container.encode(legal_name, forKey: .legal_name)
        try container.encode(lifecycle_state, forKey: .lifecycle_state)
        try container.encode(logo_url, forKey: .logo_url)
        try container.encode(markets, forKey: .markets)
        try container.encode(menu_links, forKey: .menu_links)
        try container.encode(name, forKey: .name)
        try container.encode(postal_address, forKey: .postal_address)
        try container.encode(sender_name, forKey: .sender_name)
        try container.encode(social_links, forKey: .social_links)
        try container.encode(support_email, forKey: .support_email)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(valid_from, forKey: .valid_from)
        try container.encode(valid_until, forKey: .valid_until)
        try container.encode(width, forKey: .width)
    }

    public func toMap() -> [String: Any] {
        return [
            "color_accent": color_accent as Any,
            "color_bg": color_bg as Any,
            "color_text": color_text as Any,
            "created_at": created_at as Any,
            "enabled": enabled as Any,
            "font_family": font_family as Any,
            "footer_note": footer_note as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "legal_name": legal_name as Any,
            "lifecycle_state": lifecycle_state as Any,
            "logo_url": logo_url as Any,
            "markets": markets as Any,
            "menu_links": menu_links as Any,
            "name": name as Any,
            "postal_address": postal_address as Any,
            "sender_name": sender_name as Any,
            "social_links": social_links as Any,
            "support_email": support_email as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any,
            "width": width as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Layout {
        return Layout(
            color_accent: map["color_accent"] as! String,
            color_bg: map["color_bg"] as! String,
            color_text: map["color_text"] as! String,
            created_at: map["created_at"] as! String,
            enabled: map["enabled"] as! Bool,
            font_family: map["font_family"] as! String,
            footer_note: map["footer_note"] as! String,
            id: map["id"] as! String,
            is_default: map["is_default"] as! Bool,
            legal_name: map["legal_name"] as! String,
            lifecycle_state: map["lifecycle_state"] as! String,
            logo_url: map["logo_url"] as! String,
            markets: (map["markets"] as! [Any]).map { AnyCodable($0) },
            menu_links: (map["menu_links"] as! [Any]).map { AnyCodable($0) },
            name: map["name"] as! String,
            postal_address: map["postal_address"] as! String,
            sender_name: map["sender_name"] as! String,
            social_links: (map["social_links"] as! [Any]).map { AnyCodable($0) },
            support_email: map["support_email"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String,
            valid_from: map["valid_from"] as! String,
            valid_until: map["valid_until"] as! String,
            width: map["width"] as! String
        )
    }
}
