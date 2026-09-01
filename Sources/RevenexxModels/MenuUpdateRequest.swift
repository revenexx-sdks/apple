import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value. `items` is replaced wholesale when sent.
open class MenuUpdateRequest<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case label = "label"
    }

    /// The ordered navigation tree. Replaces the stored one completely.
    public let items: [PageMenuItem<T>]?
    /// What this menu is called for the people who edit it.
    public let label: String?

    init(
        items: [PageMenuItem<T>]?,
        label: String?
    ) {
        self.items = items
        self.label = label
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([PageMenuItem<T>].self, forKey: .items)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(label, forKey: .label)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "label": label as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MenuUpdateRequest {
        return MenuUpdateRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { PageMenuItem.from(map: $0) },
            label: map["label"] as? String
        )
    }
}
