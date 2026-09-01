import Foundation
import JSONCodable

/// 
open class Template: Codable {

    enum CodingKeys: String, CodingKey {
        case body_html = "body_html"
        case body_text = "body_text"
        case channel = "channel"
        case content_sid = "content_sid"
        case created_at = "created_at"
        case design = "design"
        case enabled = "enabled"
        case has_unpublished_changes = "has_unpublished_changes"
        case id = "id"
        case is_published = "is_published"
        case key = "key"
        case layout_id = "layout_id"
        case lifecycle_state = "lifecycle_state"
        case locale = "locale"
        case markets = "markets"
        case message_class = "message_class"
        case published_version_id = "published_version_id"
        case source_library_key = "source_library_key"
        case subject = "subject"
        case tenant_id = "tenant_id"
        case test_mode = "test_mode"
        case title = "title"
        case updated_at = "updated_at"
        case uses_raw_html = "uses_raw_html"
        case valid_from = "valid_from"
        case valid_until = "valid_until"
        case variable_defaults = "variable_defaults"
        case variables = "variables"
        case whatsapp_category = "whatsapp_category"
    }

    /// 
    public let body_html: String
    /// 
    public let body_text: String
    /// 
    public let channel: String
    /// 
    public let content_sid: String
    /// 
    public let created_at: String
    /// 
    public let design: [AnyCodable]
    /// 
    public let enabled: Bool
    /// 
    public let has_unpublished_changes: String
    /// 
    public let id: String
    /// 
    public let is_published: String
    /// 
    public let key: String
    /// 
    public let layout_id: String
    /// 
    public let lifecycle_state: String
    /// 
    public let locale: String
    /// 
    public let markets: [AnyCodable]
    /// 
    public let message_class: String
    /// 
    public let published_version_id: String
    /// 
    public let source_library_key: String
    /// 
    public let subject: String
    /// 
    public let tenant_id: String
    /// 
    public let test_mode: Bool
    /// 
    public let title: String
    /// 
    public let updated_at: String
    /// 
    public let uses_raw_html: String
    /// 
    public let valid_from: String
    /// 
    public let valid_until: String
    /// 
    public let variable_defaults: [AnyCodable]
    /// 
    public let variables: [AnyCodable]
    /// 
    public let whatsapp_category: String

    init(
        body_html: String,
        body_text: String,
        channel: String,
        content_sid: String,
        created_at: String,
        design: [AnyCodable],
        enabled: Bool,
        has_unpublished_changes: String,
        id: String,
        is_published: String,
        key: String,
        layout_id: String,
        lifecycle_state: String,
        locale: String,
        markets: [AnyCodable],
        message_class: String,
        published_version_id: String,
        source_library_key: String,
        subject: String,
        tenant_id: String,
        test_mode: Bool,
        title: String,
        updated_at: String,
        uses_raw_html: String,
        valid_from: String,
        valid_until: String,
        variable_defaults: [AnyCodable],
        variables: [AnyCodable],
        whatsapp_category: String
    ) {
        self.body_html = body_html
        self.body_text = body_text
        self.channel = channel
        self.content_sid = content_sid
        self.created_at = created_at
        self.design = design
        self.enabled = enabled
        self.has_unpublished_changes = has_unpublished_changes
        self.id = id
        self.is_published = is_published
        self.key = key
        self.layout_id = layout_id
        self.lifecycle_state = lifecycle_state
        self.locale = locale
        self.markets = markets
        self.message_class = message_class
        self.published_version_id = published_version_id
        self.source_library_key = source_library_key
        self.subject = subject
        self.tenant_id = tenant_id
        self.test_mode = test_mode
        self.title = title
        self.updated_at = updated_at
        self.uses_raw_html = uses_raw_html
        self.valid_from = valid_from
        self.valid_until = valid_until
        self.variable_defaults = variable_defaults
        self.variables = variables
        self.whatsapp_category = whatsapp_category
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.body_html = try container.decode(String.self, forKey: .body_html)
        self.body_text = try container.decode(String.self, forKey: .body_text)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.content_sid = try container.decode(String.self, forKey: .content_sid)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.design = try container.decode([AnyCodable].self, forKey: .design)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.has_unpublished_changes = try container.decode(String.self, forKey: .has_unpublished_changes)
        self.id = try container.decode(String.self, forKey: .id)
        self.is_published = try container.decode(String.self, forKey: .is_published)
        self.key = try container.decode(String.self, forKey: .key)
        self.layout_id = try container.decode(String.self, forKey: .layout_id)
        self.lifecycle_state = try container.decode(String.self, forKey: .lifecycle_state)
        self.locale = try container.decode(String.self, forKey: .locale)
        self.markets = try container.decode([AnyCodable].self, forKey: .markets)
        self.message_class = try container.decode(String.self, forKey: .message_class)
        self.published_version_id = try container.decode(String.self, forKey: .published_version_id)
        self.source_library_key = try container.decode(String.self, forKey: .source_library_key)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.test_mode = try container.decode(Bool.self, forKey: .test_mode)
        self.title = try container.decode(String.self, forKey: .title)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.uses_raw_html = try container.decode(String.self, forKey: .uses_raw_html)
        self.valid_from = try container.decode(String.self, forKey: .valid_from)
        self.valid_until = try container.decode(String.self, forKey: .valid_until)
        self.variable_defaults = try container.decode([AnyCodable].self, forKey: .variable_defaults)
        self.variables = try container.decode([AnyCodable].self, forKey: .variables)
        self.whatsapp_category = try container.decode(String.self, forKey: .whatsapp_category)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(body_html, forKey: .body_html)
        try container.encode(body_text, forKey: .body_text)
        try container.encode(channel, forKey: .channel)
        try container.encode(content_sid, forKey: .content_sid)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(design, forKey: .design)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(has_unpublished_changes, forKey: .has_unpublished_changes)
        try container.encode(id, forKey: .id)
        try container.encode(is_published, forKey: .is_published)
        try container.encode(key, forKey: .key)
        try container.encode(layout_id, forKey: .layout_id)
        try container.encode(lifecycle_state, forKey: .lifecycle_state)
        try container.encode(locale, forKey: .locale)
        try container.encode(markets, forKey: .markets)
        try container.encode(message_class, forKey: .message_class)
        try container.encode(published_version_id, forKey: .published_version_id)
        try container.encode(source_library_key, forKey: .source_library_key)
        try container.encode(subject, forKey: .subject)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(test_mode, forKey: .test_mode)
        try container.encode(title, forKey: .title)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(uses_raw_html, forKey: .uses_raw_html)
        try container.encode(valid_from, forKey: .valid_from)
        try container.encode(valid_until, forKey: .valid_until)
        try container.encode(variable_defaults, forKey: .variable_defaults)
        try container.encode(variables, forKey: .variables)
        try container.encode(whatsapp_category, forKey: .whatsapp_category)
    }

    public func toMap() -> [String: Any] {
        return [
            "body_html": body_html as Any,
            "body_text": body_text as Any,
            "channel": channel as Any,
            "content_sid": content_sid as Any,
            "created_at": created_at as Any,
            "design": design as Any,
            "enabled": enabled as Any,
            "has_unpublished_changes": has_unpublished_changes as Any,
            "id": id as Any,
            "is_published": is_published as Any,
            "key": key as Any,
            "layout_id": layout_id as Any,
            "lifecycle_state": lifecycle_state as Any,
            "locale": locale as Any,
            "markets": markets as Any,
            "message_class": message_class as Any,
            "published_version_id": published_version_id as Any,
            "source_library_key": source_library_key as Any,
            "subject": subject as Any,
            "tenant_id": tenant_id as Any,
            "test_mode": test_mode as Any,
            "title": title as Any,
            "updated_at": updated_at as Any,
            "uses_raw_html": uses_raw_html as Any,
            "valid_from": valid_from as Any,
            "valid_until": valid_until as Any,
            "variable_defaults": variable_defaults as Any,
            "variables": variables as Any,
            "whatsapp_category": whatsapp_category as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Template {
        return Template(
            body_html: map["body_html"] as! String,
            body_text: map["body_text"] as! String,
            channel: map["channel"] as! String,
            content_sid: map["content_sid"] as! String,
            created_at: map["created_at"] as! String,
            design: (map["design"] as! [Any]).map { AnyCodable($0) },
            enabled: map["enabled"] as! Bool,
            has_unpublished_changes: map["has_unpublished_changes"] as! String,
            id: map["id"] as! String,
            is_published: map["is_published"] as! String,
            key: map["key"] as! String,
            layout_id: map["layout_id"] as! String,
            lifecycle_state: map["lifecycle_state"] as! String,
            locale: map["locale"] as! String,
            markets: (map["markets"] as! [Any]).map { AnyCodable($0) },
            message_class: map["message_class"] as! String,
            published_version_id: map["published_version_id"] as! String,
            source_library_key: map["source_library_key"] as! String,
            subject: map["subject"] as! String,
            tenant_id: map["tenant_id"] as! String,
            test_mode: map["test_mode"] as! Bool,
            title: map["title"] as! String,
            updated_at: map["updated_at"] as! String,
            uses_raw_html: map["uses_raw_html"] as! String,
            valid_from: map["valid_from"] as! String,
            valid_until: map["valid_until"] as! String,
            variable_defaults: (map["variable_defaults"] as! [Any]).map { AnyCodable($0) },
            variables: (map["variables"] as! [Any]).map { AnyCodable($0) },
            whatsapp_category: map["whatsapp_category"] as! String
        )
    }
}
