import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class Channel: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case created_at = "created_at"
        case id = "id"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
        case tenant_id = "tenant_id"
        case type = "type"
        case unassigned_visibility = "unassigned_visibility"
        case updated_at = "updated_at"
    }

    /// The scope slug Baseline matches channel assignments on (manifest.provides_scopes[].slug_source). Unique per tenant and, in practice, immutable — changing it orphans every assignment made against it.
    public let code: String?
    /// When the row was inserted, set by the database.
    public let created_at: String?
    /// Row id, and the only handle GET/PUT/DELETE /channels/{id} accept. Not the scope slug — that is `code`. No example is published because no id this app could invent names a row a tenant holds.
    public let id: String?
    /// The channel a request that names none falls back to. At most one channel carries it.
    public let is_default: Bool?
    /// A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// Display name. `labels` carries the per-locale ones.
    public let name: String?
    /// Sort position — ascending, and the tiebreak when two channels both claim is_default.
    public let position: Int?
    /// Whether the channel is in service. What 'inactive' DOES is the tenant's inactive_channel_behavior setting: on 'serve' it is a label and the channel still resolves, on 'block' /channels/context answers resolved:false with reason 'channel_inactive'. Served as the 'channels.statuses' vocabulary.
    public let status: RevenexxEnums.ChannelStatus?
    /// The tenant that owns this row. Added by the data plane, not by this app: it is not a column of schema.json, so it is read-only and `?tenant_id=` is not a filter — the key is silently dropped and never reaches the `filter` echo.
    public let tenant_id: String?
    /// One of the codes the tenant keeps under GET /channels/types — served with labels as the 'channels.types' vocabulary. Deliberately NOT an enum: the set is the tenant's own rows, not a CHECK constraint this repo could quote. A fresh install starts with storefront, punchout, marketplace, api, pos, which is why 'storefront' is the example here, but a merchant may rename or retire any of them and add their own (a feed or a print channel), so read the list rather than assuming it.
    public let type: String?
    /// What it means, IN THIS CHANNEL, that a row carries no channel assignment at all — the per-channel override of the tenant-wide unassigned_channel_visibility setting. 'inherit' (the default) takes the tenant's answer and changes nothing. 'all' shows unassigned rows: everything is on sale unless somebody carved it out, which is what an open storefront wants and what Baseline's is_visible() does today. 'assigned_only' hides them until they are explicitly assigned — the negotiated assortment a punchout contract describes, and the one answer the generated _scoped view has no way to express, which is why POST /channels/visibility exists to apply it. Rows that DO carry assignments are unaffected either way. Served with its labels as the 'channels.unassigned-visibility' vocabulary.
    public let unassigned_visibility: RevenexxEnums.ChannelUnassignedVisibility?
    /// When the row was last written, set by the database.
    public let updated_at: String?

    init(
        code: String?,
        created_at: String?,
        id: String?,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        status: RevenexxEnums.ChannelStatus?,
        tenant_id: String?,
        type: String?,
        unassigned_visibility: RevenexxEnums.ChannelUnassignedVisibility?,
        updated_at: String?
    ) {
        self.code = code
        self.created_at = created_at
        self.id = id
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
        self.tenant_id = tenant_id
        self.type = type
        self.unassigned_visibility = unassigned_visibility
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ChannelStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        if let unassigned_visibilityString = try container.decodeIfPresent(String.self, forKey: .unassigned_visibility) {
            self.unassigned_visibility = RevenexxEnums.ChannelUnassignedVisibility(rawValue: unassigned_visibilityString)
        } else {
            self.unassigned_visibility = nil
        }
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(unassigned_visibility?.rawValue, forKey: .unassigned_visibility)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any,
            "tenant_id": tenant_id as Any,
            "type": type as Any,
            "unassigned_visibility": unassigned_visibility?.rawValue as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Channel {
        return Channel(
            code: map["code"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? ChannelStatus(rawValue: map["status"] as! String) : nil,
            tenant_id: map["tenant_id"] as? String,
            type: map["type"] as? String,
            unassigned_visibility: map["unassigned_visibility"] as? String != nil ? ChannelUnassignedVisibility(rawValue: map["unassigned_visibility"] as! String) : nil,
            updated_at: map["updated_at"] as? String
        )
    }
}
