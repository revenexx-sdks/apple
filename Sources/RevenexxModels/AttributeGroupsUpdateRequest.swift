import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class AttributeGroupsUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case position = "position"
    }

    /// The group's stable identifier, and the value an `AttributeField` carries as its `group` — a SECTION of the product form, not a label. Unique per tenant and the key an import joins on.
    public let code: String?
    /// The section heading a person sees, keyed by language tag. The code is never shown to an operator; a tag nobody translated falls back to the next filled one, then to English.
    public let labels: [String: AnyCodable]?
    /// Where this section sits in a form, ascending. Sections that tie keep the order the database returns them in.
    public let position: Int?

    init(
        code: String?,
        labels: [String: AnyCodable]?,
        position: Int?
    ) {
        self.code = code
        self.labels = labels
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeGroupsUpdateRequest {
        return AttributeGroupsUpdateRequest(
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int
        )
    }
}
