import Foundation
import JSONCodable

/// Published page resolved for one language: nested block tree with i18n fallback applied and scheduled blocks filtered.
open class DeliveryPage: Codable {

    enum CodingKeys: String, CodingKey {
        case fields = "fields"
        case page = "page"
    }

    /// Field name → ordered block list ({ uuid, bundle, props, options, children }).
    public let fields: [String: AnyCodable]?
    /// 
    public let page: [String: AnyCodable]?

    init(
        fields: [String: AnyCodable]?,
        page: [String: AnyCodable]?
    ) {
        self.fields = fields
        self.page = page
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.fields = try container.decodeIfPresent([String: AnyCodable].self, forKey: .fields)
        self.page = try container.decodeIfPresent([String: AnyCodable].self, forKey: .page)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(fields, forKey: .fields)
        try container.encodeIfPresent(page, forKey: .page)
    }

    public func toMap() -> [String: Any] {
        return [
            "fields": fields as Any,
            "page": page as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DeliveryPage {
        return DeliveryPage(
            fields: map["fields"] as? [String: AnyCodable],
            page: map["page"] as? [String: AnyCodable]
        )
    }
}
