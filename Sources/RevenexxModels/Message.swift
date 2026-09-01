import Foundation
import JSONCodable

/// 
open class Message: Codable {

    enum CodingKeys: String, CodingKey {
        case attachments = "attachments"
        case attempts = "attempts"
        case binding_id = "binding_id"
        case channel = "channel"
        case click_count = "click_count"
        case clicked_at = "clicked_at"
        case created_at = "created_at"
        case data = "data"
        case delivered_at = "delivered_at"
        case error = "error"
        case from_draft = "from_draft"
        case id = "id"
        case idempotency_fingerprint = "idempotency_fingerprint"
        case idempotency_key = "idempotency_key"
        case locale = "locale"
        case market = "market"
        case message_class = "message_class"
        case open_count = "open_count"
        case opened_at = "opened_at"
        case provider_message_id = "provider_message_id"
        case scheduled_for = "scheduled_for"
        case sent_at = "sent_at"
        case source_event_id = "source_event_id"
        case status = "status"
        case subject = "subject"
        case suppression_reason = "suppression_reason"
        case template_key = "template_key"
        case tenant_id = "tenant_id"
        case to = "to"
    }

    /// 
    public let attachments: [AnyCodable]
    /// 
    public let attempts: Int
    /// 
    public let binding_id: String
    /// 
    public let channel: String
    /// 
    public let click_count: Int
    /// 
    public let clicked_at: String
    /// 
    public let created_at: String
    /// 
    public let data: [AnyCodable]
    /// 
    public let delivered_at: String
    /// 
    public let error: String
    /// 
    public let from_draft: Bool
    /// 
    public let id: String
    /// 
    public let idempotency_fingerprint: String
    /// 
    public let idempotency_key: String
    /// 
    public let locale: String
    /// 
    public let market: String
    /// 
    public let message_class: String
    /// 
    public let open_count: Int
    /// 
    public let opened_at: String
    /// 
    public let provider_message_id: String
    /// 
    public let scheduled_for: String
    /// 
    public let sent_at: String
    /// 
    public let source_event_id: String
    /// 
    public let status: String
    /// 
    public let subject: String
    /// 
    public let suppression_reason: String
    /// 
    public let template_key: String
    /// 
    public let tenant_id: String
    /// 
    public let to: String

    init(
        attachments: [AnyCodable],
        attempts: Int,
        binding_id: String,
        channel: String,
        click_count: Int,
        clicked_at: String,
        created_at: String,
        data: [AnyCodable],
        delivered_at: String,
        error: String,
        from_draft: Bool,
        id: String,
        idempotency_fingerprint: String,
        idempotency_key: String,
        locale: String,
        market: String,
        message_class: String,
        open_count: Int,
        opened_at: String,
        provider_message_id: String,
        scheduled_for: String,
        sent_at: String,
        source_event_id: String,
        status: String,
        subject: String,
        suppression_reason: String,
        template_key: String,
        tenant_id: String,
        to: String
    ) {
        self.attachments = attachments
        self.attempts = attempts
        self.binding_id = binding_id
        self.channel = channel
        self.click_count = click_count
        self.clicked_at = clicked_at
        self.created_at = created_at
        self.data = data
        self.delivered_at = delivered_at
        self.error = error
        self.from_draft = from_draft
        self.id = id
        self.idempotency_fingerprint = idempotency_fingerprint
        self.idempotency_key = idempotency_key
        self.locale = locale
        self.market = market
        self.message_class = message_class
        self.open_count = open_count
        self.opened_at = opened_at
        self.provider_message_id = provider_message_id
        self.scheduled_for = scheduled_for
        self.sent_at = sent_at
        self.source_event_id = source_event_id
        self.status = status
        self.subject = subject
        self.suppression_reason = suppression_reason
        self.template_key = template_key
        self.tenant_id = tenant_id
        self.to = to
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attachments = try container.decode([AnyCodable].self, forKey: .attachments)
        self.attempts = try container.decode(Int.self, forKey: .attempts)
        self.binding_id = try container.decode(String.self, forKey: .binding_id)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.click_count = try container.decode(Int.self, forKey: .click_count)
        self.clicked_at = try container.decode(String.self, forKey: .clicked_at)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.data = try container.decode([AnyCodable].self, forKey: .data)
        self.delivered_at = try container.decode(String.self, forKey: .delivered_at)
        self.error = try container.decode(String.self, forKey: .error)
        self.from_draft = try container.decode(Bool.self, forKey: .from_draft)
        self.id = try container.decode(String.self, forKey: .id)
        self.idempotency_fingerprint = try container.decode(String.self, forKey: .idempotency_fingerprint)
        self.idempotency_key = try container.decode(String.self, forKey: .idempotency_key)
        self.locale = try container.decode(String.self, forKey: .locale)
        self.market = try container.decode(String.self, forKey: .market)
        self.message_class = try container.decode(String.self, forKey: .message_class)
        self.open_count = try container.decode(Int.self, forKey: .open_count)
        self.opened_at = try container.decode(String.self, forKey: .opened_at)
        self.provider_message_id = try container.decode(String.self, forKey: .provider_message_id)
        self.scheduled_for = try container.decode(String.self, forKey: .scheduled_for)
        self.sent_at = try container.decode(String.self, forKey: .sent_at)
        self.source_event_id = try container.decode(String.self, forKey: .source_event_id)
        self.status = try container.decode(String.self, forKey: .status)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.suppression_reason = try container.decode(String.self, forKey: .suppression_reason)
        self.template_key = try container.decode(String.self, forKey: .template_key)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.to = try container.decode(String.self, forKey: .to)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(attachments, forKey: .attachments)
        try container.encode(attempts, forKey: .attempts)
        try container.encode(binding_id, forKey: .binding_id)
        try container.encode(channel, forKey: .channel)
        try container.encode(click_count, forKey: .click_count)
        try container.encode(clicked_at, forKey: .clicked_at)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(data, forKey: .data)
        try container.encode(delivered_at, forKey: .delivered_at)
        try container.encode(error, forKey: .error)
        try container.encode(from_draft, forKey: .from_draft)
        try container.encode(id, forKey: .id)
        try container.encode(idempotency_fingerprint, forKey: .idempotency_fingerprint)
        try container.encode(idempotency_key, forKey: .idempotency_key)
        try container.encode(locale, forKey: .locale)
        try container.encode(market, forKey: .market)
        try container.encode(message_class, forKey: .message_class)
        try container.encode(open_count, forKey: .open_count)
        try container.encode(opened_at, forKey: .opened_at)
        try container.encode(provider_message_id, forKey: .provider_message_id)
        try container.encode(scheduled_for, forKey: .scheduled_for)
        try container.encode(sent_at, forKey: .sent_at)
        try container.encode(source_event_id, forKey: .source_event_id)
        try container.encode(status, forKey: .status)
        try container.encode(subject, forKey: .subject)
        try container.encode(suppression_reason, forKey: .suppression_reason)
        try container.encode(template_key, forKey: .template_key)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(to, forKey: .to)
    }

    public func toMap() -> [String: Any] {
        return [
            "attachments": attachments as Any,
            "attempts": attempts as Any,
            "binding_id": binding_id as Any,
            "channel": channel as Any,
            "click_count": click_count as Any,
            "clicked_at": clicked_at as Any,
            "created_at": created_at as Any,
            "data": data as Any,
            "delivered_at": delivered_at as Any,
            "error": error as Any,
            "from_draft": from_draft as Any,
            "id": id as Any,
            "idempotency_fingerprint": idempotency_fingerprint as Any,
            "idempotency_key": idempotency_key as Any,
            "locale": locale as Any,
            "market": market as Any,
            "message_class": message_class as Any,
            "open_count": open_count as Any,
            "opened_at": opened_at as Any,
            "provider_message_id": provider_message_id as Any,
            "scheduled_for": scheduled_for as Any,
            "sent_at": sent_at as Any,
            "source_event_id": source_event_id as Any,
            "status": status as Any,
            "subject": subject as Any,
            "suppression_reason": suppression_reason as Any,
            "template_key": template_key as Any,
            "tenant_id": tenant_id as Any,
            "to": to as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Message {
        return Message(
            attachments: (map["attachments"] as! [Any]).map { AnyCodable($0) },
            attempts: map["attempts"] as! Int,
            binding_id: map["binding_id"] as! String,
            channel: map["channel"] as! String,
            click_count: map["click_count"] as! Int,
            clicked_at: map["clicked_at"] as! String,
            created_at: map["created_at"] as! String,
            data: (map["data"] as! [Any]).map { AnyCodable($0) },
            delivered_at: map["delivered_at"] as! String,
            error: map["error"] as! String,
            from_draft: map["from_draft"] as! Bool,
            id: map["id"] as! String,
            idempotency_fingerprint: map["idempotency_fingerprint"] as! String,
            idempotency_key: map["idempotency_key"] as! String,
            locale: map["locale"] as! String,
            market: map["market"] as! String,
            message_class: map["message_class"] as! String,
            open_count: map["open_count"] as! Int,
            opened_at: map["opened_at"] as! String,
            provider_message_id: map["provider_message_id"] as! String,
            scheduled_for: map["scheduled_for"] as! String,
            sent_at: map["sent_at"] as! String,
            source_event_id: map["source_event_id"] as! String,
            status: map["status"] as! String,
            subject: map["subject"] as! String,
            suppression_reason: map["suppression_reason"] as! String,
            template_key: map["template_key"] as! String,
            tenant_id: map["tenant_id"] as! String,
            to: map["to"] as! String
        )
    }
}
