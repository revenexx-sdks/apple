import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelContext: Codable {

    enum CodingKeys: String, CodingKey {
        case channel = "channel"
        case default_ambiguous = "default_ambiguous"
        case policy = "policy"
        case reason = "reason"
        case requested = "requested"
        case resolved = "resolved"
        case source = "source"
    }

    /// The channel that resolved, or null. Null on every answer where `resolved` is false — including the everyday one on a tenant that has not created a channel yet.
    public let channel: String?
    /// More than one channel claims is_default; the lowest position wins and this says so.
    public let default_ambiguous: Bool?
    /// The visibility policy in force for the resolved channel.
    public let policy: ChannelPolicy?
    /// Why not, when resolved is false. Null when it resolved.
    public let reason: RevenexxEnums.ChannelUnresolvedReason?
    /// The channel code the request named, if any — lowercased and trimmed as it was matched.
    public let requested: String?
    /// Whether a channel could be resolved for this request.
    public let resolved: Bool?
    /// Where the channel came from, in the order they are tried: 'body' (the `channel` field, POST /channels/visibility only), 'query' (`?channel=`), 'header' (x-revenexx-channel), 'jwt' (the scope_context.channel claim), then 'default' (the channel flagged is_default). Null when nothing resolved. Note that 'header' is not reachable through api.revenexx.com: the gateway builds a fresh request to the app and copies a fixed set of headers into it, and x-revenexx-channel is not among them — see `policy.header`.
    public let source: RevenexxEnums.ChannelContextSource?

    init(
        channel: String?,
        default_ambiguous: Bool?,
        policy: ChannelPolicy?,
        reason: RevenexxEnums.ChannelUnresolvedReason?,
        requested: String?,
        resolved: Bool?,
        source: RevenexxEnums.ChannelContextSource?
    ) {
        self.channel = channel
        self.default_ambiguous = default_ambiguous
        self.policy = policy
        self.reason = reason
        self.requested = requested
        self.resolved = resolved
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel = try container.decodeIfPresent(String.self, forKey: .channel)
        self.default_ambiguous = try container.decodeIfPresent(Bool.self, forKey: .default_ambiguous)
        self.policy = try container.decodeIfPresent(ChannelPolicy.self, forKey: .policy)
        if let reasonString = try container.decodeIfPresent(String.self, forKey: .reason) {
            self.reason = RevenexxEnums.ChannelUnresolvedReason(rawValue: reasonString)
        } else {
            self.reason = nil
        }
        self.requested = try container.decodeIfPresent(String.self, forKey: .requested)
        self.resolved = try container.decodeIfPresent(Bool.self, forKey: .resolved)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.ChannelContextSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(default_ambiguous, forKey: .default_ambiguous)
        try container.encodeIfPresent(policy, forKey: .policy)
        try container.encodeIfPresent(reason?.rawValue, forKey: .reason)
        try container.encodeIfPresent(requested, forKey: .requested)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel": channel as Any,
            "default_ambiguous": default_ambiguous as Any,
            "policy": policy?.toMap() as Any,
            "reason": reason?.rawValue as Any,
            "requested": requested as Any,
            "resolved": resolved as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelContext {
        return ChannelContext(
            channel: map["channel"] as? String,
            default_ambiguous: map["default_ambiguous"] as? Bool,
            policy: ChannelPolicy.from(map: map["policy"] as! [String: Any]),
            reason: map["reason"] as? String != nil ? ChannelUnresolvedReason(rawValue: map["reason"] as! String) : nil,
            requested: map["requested"] as? String,
            resolved: map["resolved"] as? Bool,
            source: map["source"] as? String != nil ? ChannelContextSource(rawValue: map["source"] as! String) : nil
        )
    }
}
