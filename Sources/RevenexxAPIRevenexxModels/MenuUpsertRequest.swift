import Foundation
import JSONCodable

/// Create or update the menu identified by menuKey (idempotent per tenant). `items` is the ordered nav tree ([{ label, to, items? }]).
open class MenuUpsertRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case label = "label"
        case menuKey = "menuKey"
    }

    /// Ordered menu entries ({ label, to?, items? }).
    public let items: [Any]?
    /// 
    public let label: String
    /// Stable menu identifier, e.g. &quot;main&quot;, &quot;footer&quot;, &quot;account&quot;.
    public let menuKey: String

    init(
        items: [Any]?,
        label: String,
        menuKey: String
    ) {
        self.items = items
        self.label = label
        self.menuKey = menuKey
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([Any].self, forKey: .items)
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
            "items": items as Any,
            "label": label as Any,
            "menuKey": menuKey as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MenuUpsertRequest {
        return MenuUpsertRequest(
            items: map["items"] as? [Any],
            label: map["label"] as! String,
            menuKey: map["menuKey"] as! String
        )
    }
}
