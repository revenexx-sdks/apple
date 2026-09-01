import Foundation
import JSONCodable

/// 
open class RolePermissionsRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case permissions = "permissions"
    }

    /// The complete new set. Duplicates and blanks are ignored; an empty array revokes everything.
    public let permissions: [String]

    init(
        permissions: [String]
    ) {
        self.permissions = permissions
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.permissions = try container.decode([String].self, forKey: .permissions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(permissions, forKey: .permissions)
    }

    public func toMap() -> [String: Any] {
        return [
            "permissions": permissions as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RolePermissionsRequest {
        return RolePermissionsRequest(
            permissions: map["permissions"] as! [String]
        )
    }
}
