import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class OrderNumberRangeUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case code = "code"
        case counter = "counter"
        case metadata = "metadata"
        case padding = "padding"
        case position_step = "position_step"
        case `prefix` = "prefix"
        case step = "step"
        case suffix = "suffix"
    }

    /// 
    public let channel_id: String?
    /// Range key drawn by the app (&#039;order&#039;, &#039;delivery&#039;, &#039;return&#039;) — unique per tenant.
    public let code: String?
    /// Current counter value (default 0) — the next number draws counter+step.
    public let counter: Int?
    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// Zero-padding width of the counter (default 6).
    public let padding: Int?
    /// Position numbering increment for order items (default 10).
    public let position_step: Int?
    /// Default &#039;&#039;.
    public let `prefix`: String?
    /// Counter increment per drawn number (default 1).
    public let step: Int?
    /// Default &#039;&#039;.
    public let suffix: String?

    init(
        channel_id: String?,
        code: String?,
        counter: Int?,
        metadata: [String: AnyCodable]?,
        padding: Int?,
        position_step: Int?,
        `prefix`: String?,
        step: Int?,
        suffix: String?
    ) {
        self.channel_id = channel_id
        self.code = code
        self.counter = counter
        self.metadata = metadata
        self.padding = padding
        self.position_step = position_step
        self.`prefix` = `prefix`
        self.step = step
        self.suffix = suffix
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.counter = try container.decodeIfPresent(Int.self, forKey: .counter)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.padding = try container.decodeIfPresent(Int.self, forKey: .padding)
        self.position_step = try container.decodeIfPresent(Int.self, forKey: .position_step)
        self.`prefix` = try container.decodeIfPresent(String.self, forKey: .`prefix`)
        self.step = try container.decodeIfPresent(Int.self, forKey: .step)
        self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(counter, forKey: .counter)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(padding, forKey: .padding)
        try container.encodeIfPresent(position_step, forKey: .position_step)
        try container.encodeIfPresent(`prefix`, forKey: .`prefix`)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(suffix, forKey: .suffix)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "code": code as Any,
            "counter": counter as Any,
            "metadata": metadata as Any,
            "padding": padding as Any,
            "position_step": position_step as Any,
            "prefix": `prefix` as Any,
            "step": step as Any,
            "suffix": suffix as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderNumberRangeUpdateRequest {
        return OrderNumberRangeUpdateRequest(
            channel_id: map["channel_id"] as? String,
            code: map["code"] as? String,
            counter: map["counter"] as? Int,
            metadata: map["metadata"] as? [String: AnyCodable],
            padding: map["padding"] as? Int,
            position_step: map["position_step"] as? Int,
            prefix: map["prefix"] as? String,
            step: map["step"] as? Int,
            suffix: map["suffix"] as? String
        )
    }
}
