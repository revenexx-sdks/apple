import Foundation
import JSONCodable

/// One navigation menu, ready to render.
open class DeliveryMenu<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case items = "items"
        case label = "label"
    }

    /// The menu KEY (`main`, `footer`, `account`), not the row id — this is the handle a theme hard-codes.
    public let id: String?
    /// The ordered navigation tree, exactly as it is stored. Render it in order; nesting is `items` inside an entry.
    public let items: [PageMenuItem<T>]?
    /// What the menu is called for the people who edit it. A theme rarely renders it.
    public let label: String?

    init(
        id: String?,
        items: [PageMenuItem<T>]?,
        label: String?
    ) {
        self.id = id
        self.items = items
        self.label = label
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.items = try container.decodeIfPresent([PageMenuItem<T>].self, forKey: .items)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(label, forKey: .label)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "items": items?.map { $0.toMap() } as Any,
            "label": label as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DeliveryMenu {
        return DeliveryMenu(
            id: map["id"] as? String,
            items: (map["items"] as? [[String: Any]] ?? []).map { PageMenuItem.from(map: $0) },
            label: map["label"] as? String
        )
    }
}
