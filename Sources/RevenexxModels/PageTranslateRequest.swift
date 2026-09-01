import Foundation
import JSONCodable

/// The strings to translate. They are forwarded to the tenant's provider verbatim.
open class PageTranslateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    /// The strings to translate. This app reads no element of the list — the provider defines the contract, and the blökkli adapter sends the fields below.
    public let items: [[String: AnyCodable]]?

    init(
        items: [[String: AnyCodable]]?
    ) {
        self.items = items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageTranslateRequest {
        return PageTranslateRequest(
            items: map["items"] as? [[String: AnyCodable]]
        )
    }
}
