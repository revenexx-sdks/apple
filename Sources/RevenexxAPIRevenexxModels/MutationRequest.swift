import Foundation
import JSONCodable

/// 
open class MutationRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case langcode = "langcode"
        case payload = "payload"
        case plugin = "plugin"
    }

    /// 
    public let langcode: String?
    /// 
    public let payload: [String: AnyCodable]?
    /// Mutation plugin id (add, move, delete, duplicate, update_field_value, ...).
    public let plugin: String

    init(
        langcode: String?,
        payload: [String: AnyCodable]?,
        plugin: String
    ) {
        self.langcode = langcode
        self.payload = payload
        self.plugin = plugin
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.langcode = try container.decodeIfPresent(String.self, forKey: .langcode)
        self.payload = try container.decodeIfPresent([String: AnyCodable].self, forKey: .payload)
        self.plugin = try container.decode(String.self, forKey: .plugin)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(langcode, forKey: .langcode)
        try container.encodeIfPresent(payload, forKey: .payload)
        try container.encode(plugin, forKey: .plugin)
    }

    public func toMap() -> [String: Any] {
        return [
            "langcode": langcode as Any,
            "payload": payload as Any,
            "plugin": plugin as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MutationRequest {
        return MutationRequest(
            langcode: map["langcode"] as? String,
            payload: map["payload"] as? [String: AnyCodable],
            plugin: map["plugin"] as! String
        )
    }
}
