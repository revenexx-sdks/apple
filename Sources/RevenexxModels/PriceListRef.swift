import Foundation
import JSONCodable

/// The price list this answer came out of — enough to link to it or to explain the number to a merchant ("this came from the dealer list").
open class PriceListRef: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case id = "id"
    }

    /// The list’s unique per-tenant code.
    public let code: String?
    /// The list, by id — the same id `GET /prices/lists/{id}` takes.
    public let id: String?

    init(
        code: String?,
        id: String?
    ) {
        self.code = code
        self.id = id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(id, forKey: .id)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "id": id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceListRef {
        return PriceListRef(
            code: map["code"] as? String,
            id: map["id"] as? String
        )
    }
}
