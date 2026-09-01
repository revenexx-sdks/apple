import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_default = "is_default"
        case labels = "labels"
        case name = "name"
        case position = "position"
        case status = "status"
        case type = "type"
        case unassigned_visibility = "unassigned_visibility"
    }

    /// Stable channel code, unique per tenant (e.g. shop, punchout-acme). It is the scope slug Baseline matches channel assignments on, so it is held to Baseline's own shape: lowercase a-z/0-9 first, then a-z/0-9/_/-, up to 63 characters. Anything else is refused — a code that cannot be a scope slug leaves the channel unable to filter.
    public let code: String
    /// Mark as the default channel (default false). At most one channel carries it — setting it demotes the previous holder.
    public let is_default: Bool?
    /// Localized display names. A locale map keyed by language tag: {"en": …, "de": …}. Read the requested tag and fall back to the plain column beside it.
    public let labels: [String: AnyCodable]?
    /// Display name.
    public let name: String
    /// Sort position (default 0).
    public let position: Int?
    /// Lifecycle status (default 'active'). Whether the channel is in service. What 'inactive' DOES is the tenant's inactive_channel_behavior setting: on 'serve' it is a label and the channel still resolves, on 'block' /channels/context answers resolved:false with reason 'channel_inactive'. Served as the 'channels.statuses' vocabulary.
    public let status: RevenexxEnums.ChannelStatus?
    /// Which channel type this is. One of the codes the tenant keeps under GET /channels/types — served with labels as the 'channels.types' vocabulary. Deliberately NOT an enum: the set is the tenant's own rows, not a CHECK constraint this repo could quote. A fresh install starts with storefront, punchout, marketplace, api, pos, which is why 'storefront' is the example here, but a merchant may rename or retire any of them and add their own (a feed or a print channel), so read the list rather than assuming it. Omitted on create it falls back to the type the tenant flagged as their default, never to a hardcoded value; a code the tenant does not keep is a 400 that names the ones they do.
    public let type: String?
    /// Default 'inherit'. What it means, IN THIS CHANNEL, that a row carries no channel assignment at all — the per-channel override of the tenant-wide unassigned_channel_visibility setting. 'inherit' (the default) takes the tenant's answer and changes nothing. 'all' shows unassigned rows: everything is on sale unless somebody carved it out, which is what an open storefront wants and what Baseline's is_visible() does today. 'assigned_only' hides them until they are explicitly assigned — the negotiated assortment a punchout contract describes, and the one answer the generated _scoped view has no way to express, which is why POST /channels/visibility exists to apply it. Rows that DO carry assignments are unaffected either way. Served with its labels as the 'channels.unassigned-visibility' vocabulary.
    public let unassigned_visibility: RevenexxEnums.ChannelUnassignedVisibility?

    init(
        code: String,
        is_default: Bool?,
        labels: [String: AnyCodable]?,
        name: String,
        position: Int?,
        status: RevenexxEnums.ChannelStatus?,
        type: String?,
        unassigned_visibility: RevenexxEnums.ChannelUnassignedVisibility?
    ) {
        self.code = code
        self.is_default = is_default
        self.labels = labels
        self.name = name
        self.position = position
        self.status = status
        self.type = type
        self.unassigned_visibility = unassigned_visibility
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.is_default = try container.decodeIfPresent(Bool.self, forKey: .is_default)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ChannelStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        if let unassigned_visibilityString = try container.decodeIfPresent(String.self, forKey: .unassigned_visibility) {
            self.unassigned_visibility = RevenexxEnums.ChannelUnassignedVisibility(rawValue: unassigned_visibilityString)
        } else {
            self.unassigned_visibility = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(is_default, forKey: .is_default)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(unassigned_visibility?.rawValue, forKey: .unassigned_visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_default": is_default as Any,
            "labels": labels as Any,
            "name": name as Any,
            "position": position as Any,
            "status": status?.rawValue as Any,
            "type": type as Any,
            "unassigned_visibility": unassigned_visibility?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelCreateRequest {
        return ChannelCreateRequest(
            code: map["code"] as! String,
            is_default: map["is_default"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as! String,
            position: map["position"] as? Int,
            status: map["status"] as? String != nil ? ChannelStatus(rawValue: map["status"] as! String) : nil,
            type: map["type"] as? String,
            unassigned_visibility: map["unassigned_visibility"] as? String != nil ? ChannelUnassignedVisibility(rawValue: map["unassigned_visibility"] as! String) : nil
        )
    }
}
