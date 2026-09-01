import Foundation
import JSONCodable

/// One navigation menu of the tenant, addressed by the stable key a theme looks it up under.
open class Menu<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case created_by = "created_by"
        case deleted_at = "deleted_at"
        case id = "id"
        case items = "items"
        case label = "label"
        case menu_key = "menu_key"
        case updated_at = "updated_at"
    }

    /// When the menu was created.
    public let created_at: String?
    /// The user id that created the menu.
    public let created_by: String?
    /// The tombstone. A soft-deleted menu disappears from the renderer immediately.
    public let deleted_at: String?
    /// The menu row id. Used by the management routes; the renderer addresses a menu by its `menu_key` instead, because that is the thing a theme hard-codes.
    public let id: String?
    /// The ordered navigation tree itself. Stored exactly as it was sent, so the theme and the editor agree on the shape without this app enforcing one.
    public let items: [PageMenuItem<T>]?
    /// What this menu is called for the people who edit it. Never rendered in the storefront.
    public let label: String?
    /// The stable name the theme asks for a menu by — `main`, `footer`, `account`. It is what makes seeding idempotent and what a header component looks up; renaming it detaches the menu from the theme slot.
    public let menu_key: String?
    /// When the menu was last replaced. The upsert rewrites `items` wholesale, so this is the timestamp of the whole navigation, not of one entry.
    public let updated_at: String?

    init(
        created_at: String?,
        created_by: String?,
        deleted_at: String?,
        id: String?,
        items: [PageMenuItem<T>]?,
        label: String?,
        menu_key: String?,
        updated_at: String?
    ) {
        self.created_at = created_at
        self.created_by = created_by
        self.deleted_at = deleted_at
        self.id = id
        self.items = items
        self.label = label
        self.menu_key = menu_key
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.created_by = try container.decodeIfPresent(String.self, forKey: .created_by)
        self.deleted_at = try container.decodeIfPresent(String.self, forKey: .deleted_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.items = try container.decodeIfPresent([PageMenuItem<T>].self, forKey: .items)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.menu_key = try container.decodeIfPresent(String.self, forKey: .menu_key)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(created_by, forKey: .created_by)
        try container.encodeIfPresent(deleted_at, forKey: .deleted_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(menu_key, forKey: .menu_key)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "created_by": created_by as Any,
            "deleted_at": deleted_at as Any,
            "id": id as Any,
            "items": items?.map { $0.toMap() } as Any,
            "label": label as Any,
            "menu_key": menu_key as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Menu {
        return Menu(
            created_at: map["created_at"] as? String,
            created_by: map["created_by"] as? String,
            deleted_at: map["deleted_at"] as? String,
            id: map["id"] as? String,
            items: (map["items"] as? [[String: Any]] ?? []).map { PageMenuItem.from(map: $0) },
            label: map["label"] as? String,
            menu_key: map["menu_key"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
