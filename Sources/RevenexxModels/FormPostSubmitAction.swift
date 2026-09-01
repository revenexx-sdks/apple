import Foundation
import JSONCodable

/// One post-submit action. `webhook` POSTs `{form, source, data}` to `url`; `entity` writes the mapped fields into another app's entity; `event` is a no-op, because `form.submitted` already carries it.
open class FormPostSubmitAction<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case enabled = "enabled"
        case entity = "entity"
        case mapping = "mapping"
        case method = "method"
        case path = "path"
        case type = "type"
        case url = "url"
        case data
    }

    /// Entity actions: the app that owns the target entity, e.g. 'crm'.
    public let app: String?
    /// Disabled actions are skipped. An action with no flag is not run.
    public let enabled: Bool?
    /// Entity actions: the entity to write, e.g. 'contacts'.
    public let entity: String?
    /// Entity actions: which submitted value becomes which column — `{"source": "email", "target": "email"}` reads `data.email` and writes it to the target's `email`.
    public let mapping: [FormActionMapping]?
    /// Webhook actions: the HTTP method. Defaults to POST.
    public let method: String?
    /// Entity actions: an explicit route to POST to, instead of the one built from `app` and `entity`.
    public let path: String?
    /// Which action this is: 'webhook', 'entity' or 'event'.
    public let type: String?
    /// Webhook actions: where to POST. It is called with an 8 second timeout and its answer is not shown to the visitor.
    public let url: String?
    /// Additional properties
    public let data: T

    init(
        app: String?,
        enabled: Bool?,
        entity: String?,
        mapping: [FormActionMapping]?,
        method: String?,
        path: String?,
        type: String?,
        url: String?,
        data: T
    ) {
        self.app = app
        self.enabled = enabled
        self.entity = entity
        self.mapping = mapping
        self.method = method
        self.path = path
        self.type = type
        self.url = url
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.entity = try container.decodeIfPresent(String.self, forKey: .entity)
        self.mapping = try container.decodeIfPresent([FormActionMapping].self, forKey: .mapping)
        self.method = try container.decodeIfPresent(String.self, forKey: .method)
        self.path = try container.decodeIfPresent(String.self, forKey: .path)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(entity, forKey: .entity)
        try container.encodeIfPresent(mapping, forKey: .mapping)
        try container.encodeIfPresent(method, forKey: .method)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "enabled": enabled as Any,
            "entity": entity as Any,
            "mapping": mapping?.map { $0.toMap() } as Any,
            "method": method as Any,
            "path": path as Any,
            "type": type as Any,
            "url": url as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormPostSubmitAction {
        return FormPostSubmitAction(
            app: map["app"] as? String,
            enabled: map["enabled"] as? Bool,
            entity: map["entity"] as? String,
            mapping: (map["mapping"] as? [[String: Any]] ?? []).map { FormActionMapping.from(map: $0) },
            method: map["method"] as? String,
            path: map["path"] as? String,
            type: map["type"] as? String,
            url: map["url"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
