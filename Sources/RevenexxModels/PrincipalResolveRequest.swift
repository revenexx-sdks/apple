import Foundation
import JSONCodable

/// 
open class PrincipalResolveRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case contact_id = "contact_id"
    }

    /// The contact the caller is acting for.
    public let contact_id: String

    init(
        contact_id: String
    ) {
        self.contact_id = contact_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.contact_id = try container.decode(String.self, forKey: .contact_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(contact_id, forKey: .contact_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "contact_id": contact_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PrincipalResolveRequest {
        return PrincipalResolveRequest(
            contact_id: map["contact_id"] as! String
        )
    }
}
