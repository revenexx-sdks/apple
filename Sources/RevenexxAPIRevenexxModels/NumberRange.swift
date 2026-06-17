import Foundation
import JSONCodable

/// 
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

    /// 
    public let channel_id: String?
    /// 
    public let code: String?
    /// 
    public let counter: Int?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let padding: Int?
    /// 
    public let position_step: Int?
    /// 
    public let `prefix`: String?
    /// 
    public let step: Int?
    /// 
    public let suffix: String?
    /// 
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
