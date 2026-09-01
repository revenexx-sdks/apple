import Foundation
import JSONCodable

/// Name the family either way — `family_id` wins when both are sent. The family has to exist already; this route assigns one, it does not create one.
open class ProductFamilyAssignRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case family_code = "family_code"
        case family_id = "family_id"
    }

    /// Alternative to family_id — a `families.code` this tenant holds, from `GET /products/families`. No example: a code is tenant data, and any value published here names a family somebody does not have.
    public let family_code: String?
    /// The family to assign.
    public let family_id: String?

    init(
        family_code: String?,
        family_id: String?
    ) {
        self.family_code = family_code
        self.family_id = family_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.family_code = try container.decodeIfPresent(String.self, forKey: .family_code)
        self.family_id = try container.decodeIfPresent(String.self, forKey: .family_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(family_code, forKey: .family_code)
        try container.encodeIfPresent(family_id, forKey: .family_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "family_code": family_code as Any,
            "family_id": family_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProductFamilyAssignRequest {
        return ProductFamilyAssignRequest(
            family_code: map["family_code"] as? String,
            family_id: map["family_id"] as? String
        )
    }
}
