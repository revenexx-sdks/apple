import Foundation
import JSONCodable

/// 
open class RolePermissionsResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case permissions = "permissions"
    }

    /// The role that was written.
    public let key: String?
    /// Its complete new set, after de-duplication.
    public let permissions: [String]?

    init(
        key: String?,
        permissions: [String]?
    ) {
        self.key = key
        self.permissions = permissions
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.key = try container.decodeIfPresent(String.self, forKey: .key)
        self.permissions = try container.decodeIfPresent([String].self, forKey: .permissions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(key, forKey: .key)
        try container.encodeIfPresent(permissions, forKey: .permissions)
    }

    public func toMap() -> [String: Any] {
        return [
            "key": key as Any,
            "permissions": permissions as Any
        ]
    }

    public static func from(map: [String: Any] ) -> RolePermissionsResponse {
        return RolePermissionsResponse(
            key: map["key"] as? String,
            permissions: map["permissions"] as? [String]
        )
    }
}
