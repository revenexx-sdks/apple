import Foundation
import JSONCodable

/// Identity
open class Identity: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case provider = "provider"
        case providerAccessToken = "providerAccessToken"
        case providerAccessTokenExpiry = "providerAccessTokenExpiry"
        case providerEmail = "providerEmail"
        case providerRefreshToken = "providerRefreshToken"
        case providerUid = "providerUid"
        case userId = "userId"
    }

    /// Identity creation date in ISO 8601 format.
    public let createdAt: String
    /// Identity ID.
    public let id: String
    /// Identity update date in ISO 8601 format.
    public let updatedAt: String
    /// Identity Provider.
    public let provider: String
    /// Identity Provider Access Token.
    public let providerAccessToken: String
    /// The date of when the access token expires in ISO 8601 format.
    public let providerAccessTokenExpiry: String
    /// Email of the User in the Identity Provider.
    public let providerEmail: String
    /// Identity Provider Refresh Token.
    public let providerRefreshToken: String
    /// ID of the User in the Identity Provider.
    public let providerUid: String
    /// User ID.
    public let userId: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        provider: String,
        providerAccessToken: String,
        providerAccessTokenExpiry: String,
        providerEmail: String,
        providerRefreshToken: String,
        providerUid: String,
        userId: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.provider = provider
        self.providerAccessToken = providerAccessToken
        self.providerAccessTokenExpiry = providerAccessTokenExpiry
        self.providerEmail = providerEmail
        self.providerRefreshToken = providerRefreshToken
        self.providerUid = providerUid
        self.userId = userId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.provider = try container.decode(String.self, forKey: .provider)
        self.providerAccessToken = try container.decode(String.self, forKey: .providerAccessToken)
        self.providerAccessTokenExpiry = try container.decode(String.self, forKey: .providerAccessTokenExpiry)
        self.providerEmail = try container.decode(String.self, forKey: .providerEmail)
        self.providerRefreshToken = try container.decode(String.self, forKey: .providerRefreshToken)
        self.providerUid = try container.decode(String.self, forKey: .providerUid)
        self.userId = try container.decode(String.self, forKey: .userId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(provider, forKey: .provider)
        try container.encode(providerAccessToken, forKey: .providerAccessToken)
        try container.encode(providerAccessTokenExpiry, forKey: .providerAccessTokenExpiry)
        try container.encode(providerEmail, forKey: .providerEmail)
        try container.encode(providerRefreshToken, forKey: .providerRefreshToken)
        try container.encode(providerUid, forKey: .providerUid)
        try container.encode(userId, forKey: .userId)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "provider": provider as Any,
            "providerAccessToken": providerAccessToken as Any,
            "providerAccessTokenExpiry": providerAccessTokenExpiry as Any,
            "providerEmail": providerEmail as Any,
            "providerRefreshToken": providerRefreshToken as Any,
            "providerUid": providerUid as Any,
            "userId": userId as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Identity {
        return Identity(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            provider: map["provider"] as! String,
            providerAccessToken: map["providerAccessToken"] as! String,
            providerAccessTokenExpiry: map["providerAccessTokenExpiry"] as! String,
            providerEmail: map["providerEmail"] as! String,
            providerRefreshToken: map["providerRefreshToken"] as! String,
            providerUid: map["providerUid"] as! String,
            userId: map["userId"] as! String
        )
    }
}
