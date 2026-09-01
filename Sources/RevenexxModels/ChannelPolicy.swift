import Foundation
import JSONCodable
import RevenexxEnums

/// The visibility policy in force for the resolved channel.
open class ChannelPolicy: Codable {

    enum CodingKeys: String, CodingKey {
        case dimension = "dimension"
        case header = "header"
        case inactive_channel_behavior = "inactive_channel_behavior"
        case jwt_path = "jwt_path"
        case match_mode = "match_mode"
        case require_channel_context = "require_channel_context"
        case source = "source"
        case tenant_default = "tenant_default"
        case unassigned_visibility = "unassigned_visibility"
    }

    /// Always 'channel' — the scope dimension this app provides.
    public let dimension: String?
    /// The header name Baseline uses for this dimension. Through api.revenexx.com it does NOT reach the app — the gateway builds a fresh request downstream and forwards only its own headers — so use `?channel=` (or `channel` in the body of POST /channels/visibility) instead. The header path applies to a direct in-cluster call to the app.
    public let header: String?
    /// The tenant setting, echoed: what `status = 'inactive'` DOES. 'serve' makes it a label and the channel still resolves; 'block' makes resolution fail with reason 'channel_inactive', and the policy then falls back to the tenant answer.
    public let inactive_channel_behavior: RevenexxEnums.ChannelInactiveBehavior?
    /// The claim path in the forwarded identity token that names the active channel, tried after the query and the header and before the default channel.
    public let jwt_path: String?
    /// How Baseline matches the dimension — 'single': a request is in exactly one channel at a time, never a set.
    public let match_mode: String?
    /// The tenant setting, echoed: whether a request naming no channel is refused rather than falling back to the default channel. On POST /channels/visibility that refusal is the single 400 this app makes of its own accord.
    public let require_channel_context: Bool?
    /// Whether the answer came from the tenant setting or this channel's own override. Only a channel that actually resolved gets a say — a blocked or unknown channel falls back to 'tenant'.
    public let source: RevenexxEnums.ChannelPolicySource?
    /// The tenant-wide baseline, so a caller can see what this channel overrode. Equal to `unassigned_visibility` whenever `source` is 'tenant'.
    public let tenant_default: RevenexxEnums.ChannelPolicyTenantDefault?
    /// What a row with NO channel assignment means. 'all' is Baseline's open-by-default semantic, reproduced exactly; 'assigned_only' is the closed assortment the _scoped view cannot express.
    public let unassigned_visibility: RevenexxEnums.ChannelUnassignedPolicy?

    init(
        dimension: String?,
        header: String?,
        inactive_channel_behavior: RevenexxEnums.ChannelInactiveBehavior?,
        jwt_path: String?,
        match_mode: String?,
        require_channel_context: Bool?,
        source: RevenexxEnums.ChannelPolicySource?,
        tenant_default: RevenexxEnums.ChannelPolicyTenantDefault?,
        unassigned_visibility: RevenexxEnums.ChannelUnassignedPolicy?
    ) {
        self.dimension = dimension
        self.header = header
        self.inactive_channel_behavior = inactive_channel_behavior
        self.jwt_path = jwt_path
        self.match_mode = match_mode
        self.require_channel_context = require_channel_context
        self.source = source
        self.tenant_default = tenant_default
        self.unassigned_visibility = unassigned_visibility
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.dimension = try container.decodeIfPresent(String.self, forKey: .dimension)
        self.header = try container.decodeIfPresent(String.self, forKey: .header)
        if let inactive_channel_behaviorString = try container.decodeIfPresent(String.self, forKey: .inactive_channel_behavior) {
            self.inactive_channel_behavior = RevenexxEnums.ChannelInactiveBehavior(rawValue: inactive_channel_behaviorString)
        } else {
            self.inactive_channel_behavior = nil
        }
        self.jwt_path = try container.decodeIfPresent(String.self, forKey: .jwt_path)
        self.match_mode = try container.decodeIfPresent(String.self, forKey: .match_mode)
        self.require_channel_context = try container.decodeIfPresent(Bool.self, forKey: .require_channel_context)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ChannelPolicySource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        if let tenant_defaultString = try container.decodeIfPresent(String.self, forKey: .tenant_default) {
            self.tenant_default = RevenexxEnums.ChannelPolicyTenantDefault(rawValue: tenant_defaultString)
        } else {
            self.tenant_default = nil
        }
        if let unassigned_visibilityString = try container.decodeIfPresent(String.self, forKey: .unassigned_visibility) {
            self.unassigned_visibility = RevenexxEnums.ChannelUnassignedPolicy(rawValue: unassigned_visibilityString)
        } else {
            self.unassigned_visibility = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(dimension, forKey: .dimension)
        try container.encodeIfPresent(header, forKey: .header)
        try container.encodeIfPresent(inactive_channel_behavior?.rawValue, forKey: .inactive_channel_behavior)
        try container.encodeIfPresent(jwt_path, forKey: .jwt_path)
        try container.encodeIfPresent(match_mode, forKey: .match_mode)
        try container.encodeIfPresent(require_channel_context, forKey: .require_channel_context)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(tenant_default?.rawValue, forKey: .tenant_default)
        try container.encodeIfPresent(unassigned_visibility?.rawValue, forKey: .unassigned_visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "dimension": dimension as Any,
            "header": header as Any,
            "inactive_channel_behavior": inactive_channel_behavior?.rawValue as Any,
            "jwt_path": jwt_path as Any,
            "match_mode": match_mode as Any,
            "require_channel_context": require_channel_context as Any,
            "source": source?.rawValue as Any,
            "tenant_default": tenant_default?.rawValue as Any,
            "unassigned_visibility": unassigned_visibility?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelPolicy {
        return ChannelPolicy(
            dimension: map["dimension"] as? String,
            header: map["header"] as? String,
            inactive_channel_behavior: map["inactive_channel_behavior"] as? String != nil ? ChannelInactiveBehavior(rawValue: map["inactive_channel_behavior"] as! String) : nil,
            jwt_path: map["jwt_path"] as? String,
            match_mode: map["match_mode"] as? String,
            require_channel_context: map["require_channel_context"] as? Bool,
            source: map["source"] as? String != nil ? ChannelPolicySource(rawValue: map["source"] as! String) : nil,
            tenant_default: map["tenant_default"] as? String != nil ? ChannelPolicyTenantDefault(rawValue: map["tenant_default"] as! String) : nil,
            unassigned_visibility: map["unassigned_visibility"] as? String != nil ? ChannelUnassignedPolicy(rawValue: map["unassigned_visibility"] as! String) : nil
        )
    }
}
