import Foundation
import JSONCodable

/// One entry of a navigation menu. Stored verbatim, so a theme may carry extra keys of its own alongside these.
open class PageMenuItem<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case label = "label"
        case to = "to"
        case data
    }

    /// Sub-entries. This is how a two-level main navigation or a grouped footer is stored.
    public let items: [[String: AnyCodable]]?
    /// The words a visitor clicks.
    public let label: String?
    /// Where the entry goes: a page slug this app serves, a path the theme routes, or an absolute URL to somewhere else.
    public let to: String?
    /// Additional properties
    public let data: T

    init(
        items: [[String: AnyCodable]]?,
        label: String?,
        to: String?,
        data: T
    ) {
        self.items = items
        self.label = label
        self.to = to
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .items)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.to = try container.decodeIfPresent(String.self, forKey: .to)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(to, forKey: .to)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items as Any,
            "label": label as Any,
            "to": to as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> PageMenuItem {
        return PageMenuItem(
            items: map["items"] as? [[String: AnyCodable]],
            label: map["label"] as? String,
            to: map["to"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
