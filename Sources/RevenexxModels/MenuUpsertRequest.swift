import Foundation
import JSONCodable

/// Create or replace the menu identified by menuKey (idempotent per tenant). `items` is written wholesale — there is no per-entry edit, so send the whole tree every time.
open class MenuUpsertRequest<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case label = "label"
        case menuKey = "menuKey"
    }

    /// The ordered navigation tree. Replaces the stored one completely.
    public let items: [PageMenuItem<T>]?
    /// What this menu is called for the people who edit it. Required on a create; an update keeps the label it had when this is left out.
    public let label: String
    /// The stable slot the theme asks for this menu by. Idempotency is keyed on it: sending an existing key replaces that menu instead of creating a second one.
    public let menuKey: String

    init(
        items: [PageMenuItem<T>]?,
        label: String,
        menuKey: String
    ) {
        self.items = items
        self.label = label
        self.menuKey = menuKey
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([PageMenuItem<T>].self, forKey: .items)
        self.label = try container.decode(String.self, forKey: .label)
        self.menuKey = try container.decode(String.self, forKey: .menuKey)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encode(label, forKey: .label)
        try container.encode(menuKey, forKey: .menuKey)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "label": label as Any,
            "menuKey": menuKey as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MenuUpsertRequest {
        return MenuUpsertRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { PageMenuItem.from(map: $0) },
            label: map["label"] as! String,
            menuKey: map["menuKey"] as! String
        )
    }
}
