import Foundation
import JSONCodable

/// 
open class LibraryTemplate: Codable {

    enum CodingKeys: String, CodingKey {
        case body_html = "body_html"
        case body_text = "body_text"
        case channel = "channel"
        case created_at = "created_at"
        case description = "description"
        case design = "design"
        case id = "id"
        case key = "key"
        case locale = "locale"
        case subject = "subject"
        case suggested_event = "suggested_event"
        case suggested_recipient = "suggested_recipient"
        case title = "title"
        case updated_at = "updated_at"
        case variables = "variables"
    }

    /// 
    public let body_html: String
    /// 
    public let body_text: String
    /// 
    public let channel: String
    /// 
    public let created_at: String
    /// 
    public let description: String
    /// 
    public let design: [AnyCodable]
    /// 
    public let id: String
    /// 
    public let key: String
    /// 
    public let locale: String
    /// 
    public let subject: String
    /// 
    public let suggested_event: String
    /// 
    public let suggested_recipient: String
    /// 
    public let title: String
    /// 
    public let updated_at: String
    /// 
    public let variables: [AnyCodable]

    init(
        body_html: String,
        body_text: String,
        channel: String,
        created_at: String,
        description: String,
        design: [AnyCodable],
        id: String,
        key: String,
        locale: String,
        subject: String,
        suggested_event: String,
        suggested_recipient: String,
        title: String,
        updated_at: String,
        variables: [AnyCodable]
    ) {
        self.body_html = body_html
        self.body_text = body_text
        self.channel = channel
        self.created_at = created_at
        self.description = description
        self.design = design
        self.id = id
        self.key = key
        self.locale = locale
        self.subject = subject
        self.suggested_event = suggested_event
        self.suggested_recipient = suggested_recipient
        self.title = title
        self.updated_at = updated_at
        self.variables = variables
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.body_html = try container.decode(String.self, forKey: .body_html)
        self.body_text = try container.decode(String.self, forKey: .body_text)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.description = try container.decode(String.self, forKey: .description)
        self.design = try container.decode([AnyCodable].self, forKey: .design)
        self.id = try container.decode(String.self, forKey: .id)
        self.key = try container.decode(String.self, forKey: .key)
        self.locale = try container.decode(String.self, forKey: .locale)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.suggested_event = try container.decode(String.self, forKey: .suggested_event)
        self.suggested_recipient = try container.decode(String.self, forKey: .suggested_recipient)
        self.title = try container.decode(String.self, forKey: .title)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.variables = try container.decode([AnyCodable].self, forKey: .variables)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(body_html, forKey: .body_html)
        try container.encode(body_text, forKey: .body_text)
        try container.encode(channel, forKey: .channel)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(description, forKey: .description)
        try container.encode(design, forKey: .design)
        try container.encode(id, forKey: .id)
        try container.encode(key, forKey: .key)
        try container.encode(locale, forKey: .locale)
        try container.encode(subject, forKey: .subject)
        try container.encode(suggested_event, forKey: .suggested_event)
        try container.encode(suggested_recipient, forKey: .suggested_recipient)
        try container.encode(title, forKey: .title)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(variables, forKey: .variables)
    }

    public func toMap() -> [String: Any] {
        return [
            "body_html": body_html as Any,
            "body_text": body_text as Any,
            "channel": channel as Any,
            "created_at": created_at as Any,
            "description": description as Any,
            "design": design as Any,
            "id": id as Any,
            "key": key as Any,
            "locale": locale as Any,
            "subject": subject as Any,
            "suggested_event": suggested_event as Any,
            "suggested_recipient": suggested_recipient as Any,
            "title": title as Any,
            "updated_at": updated_at as Any,
            "variables": variables as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LibraryTemplate {
        return LibraryTemplate(
            body_html: map["body_html"] as! String,
            body_text: map["body_text"] as! String,
            channel: map["channel"] as! String,
            created_at: map["created_at"] as! String,
            description: map["description"] as! String,
            design: (map["design"] as! [Any]).map { AnyCodable($0) },
            id: map["id"] as! String,
            key: map["key"] as! String,
            locale: map["locale"] as! String,
            subject: map["subject"] as! String,
            suggested_event: map["suggested_event"] as! String,
            suggested_recipient: map["suggested_recipient"] as! String,
            title: map["title"] as! String,
            updated_at: map["updated_at"] as! String,
            variables: (map["variables"] as! [Any]).map { AnyCodable($0) }
        )
    }
}
