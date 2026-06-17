import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class MenuUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case label = "label"
    }

    /// 
    public let items: [Any]?
    /// 
    public let label: String?

    init(
        items: [Any]?,
        label: String?
    ) {
        self.items = items
        self.label = label
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([Any].self, forKey: .items)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(label, forKey: .label)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items as Any,
            "label": label as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MenuUpdateRequest {
        return MenuUpdateRequest(
            items: map["items"] as? [Any],
            label: map["label"] as? String
        )
    }
}
