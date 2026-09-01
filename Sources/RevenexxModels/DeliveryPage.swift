import Foundation
import JSONCodable

/// One published page resolved for one language, ready to render: i18n fallback applied per field, blocks outside their publish window removed, library references expanded inline.
open class DeliveryPage: Codable {

    enum CodingKeys: String, CodingKey {
        case fields = "fields"
        case page = "page"
    }

    /// The page's block tree, keyed by field name — `{ "content": [ … ] }`. A theme renders the field it knows and ignores the rest.
    public let fields: [String: AnyCodable]?
    /// The page frame — everything a theme needs before it starts rendering blocks.
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
