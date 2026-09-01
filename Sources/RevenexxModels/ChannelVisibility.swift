import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class ChannelVisibility: Codable {

    enum CodingKeys: String, CodingKey {
        case channel = "channel"
        case counts = "counts"
        case default_ambiguous = "default_ambiguous"
        case hidden = "hidden"
        case items = "items"
        case policy = "policy"
        case reason = "reason"
        case requested = "requested"
        case resolved = "resolved"
        case source = "source"
        case visible = "visible"
    }

    /// The channel that resolved, or null. Null on every answer where `resolved` is false — including the everyday one on a tenant that has not created a channel yet.
    public let channel: String?
    /// The three tallies, so a caller can log or alert on a batch without walking it.
    public let counts: ChannelVisibilityCounts?
    /// More than one channel claims is_default; the lowest position wins and this says so.
    public let default_ambiguous: Bool?
    /// Just the ids that must NOT be shown. The complement of `visible`; together they are every id sent, so a caller can assert nothing was dropped.
    public let hidden: [String]?
    /// One decision per row sent, in the order they were sent, so a caller can zip it back onto its own list without matching on id.
    public let items: [ChannelVisibilityDecision]?
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
    /// Just the ids that may be shown, ready to filter a result set with — the same rows `items` marks visible:true, without the reasons.
    public let visible: [String]?

    init(
        channel: String?,
        counts: ChannelVisibilityCounts?,
        default_ambiguous: Bool?,
        hidden: [String]?,
        items: [ChannelVisibilityDecision]?,
        policy: ChannelPolicy?,
        reason: RevenexxEnums.ChannelUnresolvedReason?,
        requested: String?,
        resolved: Bool?,
        source: RevenexxEnums.ChannelContextSource?,
        visible: [String]?
    ) {
        self.channel = channel
        self.counts = counts
        self.default_ambiguous = default_ambiguous
        self.hidden = hidden
        self.items = items
        self.policy = policy
        self.reason = reason
        self.requested = requested
        self.resolved = resolved
        self.source = source
        self.visible = visible
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel = try container.decodeIfPresent(String.self, forKey: .channel)
        self.counts = try container.decodeIfPresent(ChannelVisibilityCounts.self, forKey: .counts)
        self.default_ambiguous = try container.decodeIfPresent(Bool.self, forKey: .default_ambiguous)
        self.hidden = try container.decodeIfPresent([String].self, forKey: .hidden)
        self.items = try container.decodeIfPresent([ChannelVisibilityDecision].self, forKey: .items)
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
        self.visible = try container.decodeIfPresent([String].self, forKey: .visible)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel, forKey: .channel)
        try container.encodeIfPresent(counts, forKey: .counts)
        try container.encodeIfPresent(default_ambiguous, forKey: .default_ambiguous)
        try container.encodeIfPresent(hidden, forKey: .hidden)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(policy, forKey: .policy)
        try container.encodeIfPresent(reason?.rawValue, forKey: .reason)
        try container.encodeIfPresent(requested, forKey: .requested)
        try container.encodeIfPresent(resolved, forKey: .resolved)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(visible, forKey: .visible)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel": channel as Any,
            "counts": counts?.toMap() as Any,
            "default_ambiguous": default_ambiguous as Any,
            "hidden": hidden as Any,
            "items": items?.map { $0.toMap() } as Any,
            "policy": policy?.toMap() as Any,
            "reason": reason?.rawValue as Any,
            "requested": requested as Any,
            "resolved": resolved as Any,
            "source": source?.rawValue as Any,
            "visible": visible as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ChannelVisibility {
        return ChannelVisibility(
            channel: map["channel"] as? String,
            counts: ChannelVisibilityCounts.from(map: map["counts"] as! [String: Any]),
            default_ambiguous: map["default_ambiguous"] as? Bool,
            hidden: map["hidden"] as? [String],
            items: (map["items"] as? [[String: Any]] ?? []).map { ChannelVisibilityDecision.from(map: $0) },
            policy: ChannelPolicy.from(map: map["policy"] as! [String: Any]),
            reason: map["reason"] as? String != nil ? ChannelUnresolvedReason(rawValue: map["reason"] as! String) : nil,
            requested: map["requested"] as? String,
            resolved: map["resolved"] as? Bool,
            source: map["source"] as? String != nil ? ChannelContextSource(rawValue: map["source"] as! String) : nil,
            visible: map["visible"] as? [String]
        )
    }
}
