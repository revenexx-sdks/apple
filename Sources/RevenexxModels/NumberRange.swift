import Foundation
import JSONCodable

/// A counter that issues human-readable numbers, one per series: orders, delivery notes, returns. The format is {prefix}{counter padded to padding}{suffix}, and drawing a number moves the counter.
open class NumberRange: Codable {

    enum CodingKeys: String, CodingKey {
        case channel_id = "channel_id"
        case code = "code"
        case counter = "counter"
        case created_at = "created_at"
        case id = "id"
        case metadata = "metadata"
        case padding = "padding"
        case position_step = "position_step"
        case `prefix` = "prefix"
        case step = "step"
        case suffix = "suffix"
        case updated_at = "updated_at"
    }

    /// The sales channel this range was created for, as a label. It does NOT select the range: a draw finds the range by `code` alone, and the unique index (tenant, code) means one code is one range per tenant — so an order on another channel draws from the same range this one names. Null on the three seeded ranges, which is every tenant-wide range.
    public let channel_id: String?
    /// Which counter this is, in the app's own words: 'order' numbers orders, 'delivery' numbers delivery notes, 'return' numbers returns. Unique per tenant, and the value the order_number_range_code / delivery_number_range_code / return_number_range_code settings point at — a setting naming a code no range carries is the 422 'number_range_missing'.
    public let code: String?
    /// The last number DRAWN — state, not configuration. The next draw is counter + step and writes the new value back, so moving this forward skips numbers and moving it back re-issues them (and the unique index then answers 409).
    public let counter: Int?
    /// When the range was created.
    public let created_at: String?
    /// Primary key of the number range.
    public let id: String?
    /// Free-form data for the caller. This app stores it and returns it, and reads nothing out of it.
    public let metadata: [String: AnyCodable]?
    /// How wide the counter is written, zero-padded: 6 makes 123 into 000123. 0 writes the bare number. Widening it later does not renumber what was already drawn.
    public let padding: Int?
    /// The gap between the position numbers of a new order: 10 numbers the lines 10, 20, 30 — room to slot a line in between later without renumbering the rest. Read from the ORDER range only.
    public let position_step: Int?
    /// Literal text in front of the counter: 'ORD-' turns counter 123 into ORD-000123. Empty by default.
    public let `prefix`: String?
    /// How far the counter moves per draw. 1 is consecutive numbering; a larger step is what a merchant chooses who does not want their order volume readable off an invoice.
    public let step: Int?
    /// Literal text after the counter — a market or year marker on merchants who number that way. Empty by default, which is what most of them use.
    public let suffix: String?
    /// When the range last changed — which includes every single number draw, because a draw writes the counter.
    public let updated_at: String?

    init(
        channel_id: String?,
        code: String?,
        counter: Int?,
        created_at: String?,
        id: String?,
        metadata: [String: AnyCodable]?,
        padding: Int?,
        position_step: Int?,
        `prefix`: String?,
        step: Int?,
        suffix: String?,
        updated_at: String?
    ) {
        self.channel_id = channel_id
        self.code = code
        self.counter = counter
        self.created_at = created_at
        self.id = id
        self.metadata = metadata
        self.padding = padding
        self.position_step = position_step
        self.`prefix` = `prefix`
        self.step = step
        self.suffix = suffix
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.channel_id = try container.decodeIfPresent(String.self, forKey: .channel_id)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.counter = try container.decodeIfPresent(Int.self, forKey: .counter)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.padding = try container.decodeIfPresent(Int.self, forKey: .padding)
        self.position_step = try container.decodeIfPresent(Int.self, forKey: .position_step)
        self.`prefix` = try container.decodeIfPresent(String.self, forKey: .`prefix`)
        self.step = try container.decodeIfPresent(Int.self, forKey: .step)
        self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(channel_id, forKey: .channel_id)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(counter, forKey: .counter)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(padding, forKey: .padding)
        try container.encodeIfPresent(position_step, forKey: .position_step)
        try container.encodeIfPresent(`prefix`, forKey: .`prefix`)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(suffix, forKey: .suffix)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "channel_id": channel_id as Any,
            "code": code as Any,
            "counter": counter as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "metadata": metadata as Any,
            "padding": padding as Any,
            "position_step": position_step as Any,
            "prefix": `prefix` as Any,
            "step": step as Any,
            "suffix": suffix as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> NumberRange {
        return NumberRange(
            channel_id: map["channel_id"] as? String,
            code: map["code"] as? String,
            counter: map["counter"] as? Int,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            padding: map["padding"] as? Int,
            position_step: map["position_step"] as? Int,
            prefix: map["prefix"] as? String,
            step: map["step"] as? Int,
            suffix: map["suffix"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
