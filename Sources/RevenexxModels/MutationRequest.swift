import Foundation
import JSONCodable

/// One change to the page.
open class MutationRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case langcode = "langcode"
        case payload = "payload"
        case plugin = "plugin"
    }

    /// Which language the returned state should be resolved for. Not the language the change is written in — that lives in the payload.
    public let langcode: String?
    /// The arguments of that change; the keys depend on the plugin (`add` takes `{ bundle, hostEntityType, hostEntityUuid, hostField }`, `move` takes `{ uuid, preceedingUuid }`, and so on). Anything non-deterministic in it — new uuids, a library item's tree, a copied subtree — is resolved once here and stored, so replaying the log is deterministic forever.
    public let payload: [String: AnyCodable]?
    /// Which kind of change this is — `add`, `move`, `delete`, `duplicate`, `update_field_value`, `update_options`, … An id this app does not implement is refused with 400 rather than stored, because the log has to replay.
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
