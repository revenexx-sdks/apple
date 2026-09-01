import Foundation
import JSONCodable

/// The market that was read from, resolved — so a caller who passed a code back gets the uuid, and one who passed a uuid gets the code the rest of the platform stores.
open class MarketRef: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case id = "id"
    }

    /// The source market's code — the value other apps scope by.
    public let code: String?
    /// The source market's primary key.
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

    public static func from(map: [String: Any] ) -> MarketRef {
        return MarketRef(
            code: map["code"] as? String,
            id: map["id"] as? String
        )
    }
}
