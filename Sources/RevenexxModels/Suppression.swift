import Foundation
import JSONCodable

/// 
open class Suppression: Codable {

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case address_hash = "address_hash"
        case channel = "channel"
        case created_at = "created_at"
        case expires_at = "expires_at"
        case id = "id"
        case note = "note"
        case reason = "reason"
        case scope = "scope"
        case source = "source"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
    }

    /// 
    public let address: String
    /// 
    public let address_hash: String
    /// 
    public let channel: String
    /// 
    public let created_at: String
    /// 
    public let expires_at: String
    /// 
    public let id: String
    /// 
    public let note: String
    /// 
    public let reason: String
    /// 
    public let scope: String
    /// 
    public let source: String
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String

    init(
        address: String,
        address_hash: String,
        channel: String,
        created_at: String,
        expires_at: String,
        id: String,
        note: String,
        reason: String,
        scope: String,
        source: String,
        tenant_id: String,
        updated_at: String
    ) {
        self.address = address
        self.address_hash = address_hash
        self.channel = channel
        self.created_at = created_at
        self.expires_at = expires_at
        self.id = id
        self.note = note
        self.reason = reason
        self.scope = scope
        self.source = source
        self.tenant_id = tenant_id
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decode(String.self, forKey: .address)
        self.address_hash = try container.decode(String.self, forKey: .address_hash)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.expires_at = try container.decode(String.self, forKey: .expires_at)
        self.id = try container.decode(String.self, forKey: .id)
        self.note = try container.decode(String.self, forKey: .note)
        self.reason = try container.decode(String.self, forKey: .reason)
        self.scope = try container.decode(String.self, forKey: .scope)
        self.source = try container.decode(String.self, forKey: .source)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(address, forKey: .address)
        try container.encode(address_hash, forKey: .address_hash)
        try container.encode(channel, forKey: .channel)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(expires_at, forKey: .expires_at)
        try container.encode(id, forKey: .id)
        try container.encode(note, forKey: .note)
        try container.encode(reason, forKey: .reason)
        try container.encode(scope, forKey: .scope)
        try container.encode(source, forKey: .source)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "address": address as Any,
            "address_hash": address_hash as Any,
            "channel": channel as Any,
            "created_at": created_at as Any,
            "expires_at": expires_at as Any,
            "id": id as Any,
            "note": note as Any,
            "reason": reason as Any,
            "scope": scope as Any,
            "source": source as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Suppression {
        return Suppression(
            address: map["address"] as! String,
            address_hash: map["address_hash"] as! String,
            channel: map["channel"] as! String,
            created_at: map["created_at"] as! String,
            expires_at: map["expires_at"] as! String,
            id: map["id"] as! String,
            note: map["note"] as! String,
            reason: map["reason"] as! String,
            scope: map["scope"] as! String,
            source: map["source"] as! String,
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String
        )
    }
}
