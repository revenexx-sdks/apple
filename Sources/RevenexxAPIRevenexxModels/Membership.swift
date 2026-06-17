import Foundation
import JSONCodable

/// Membership
open class Membership: Codable {

    enum CodingKeys: String, CodingKey {
        case createdAt = "$createdAt"
        case id = "$id"
        case updatedAt = "$updatedAt"
        case confirm = "confirm"
        case invited = "invited"
        case joined = "joined"
        case mfa = "mfa"
        case roles = "roles"
        case teamId = "teamId"
        case teamName = "teamName"
        case userEmail = "userEmail"
        case userId = "userId"
        case userName = "userName"
    }

    /// Membership creation date in ISO 8601 format.
    public let createdAt: String
    /// Membership ID.
    public let id: String
    /// Membership update date in ISO 8601 format.
    public let updatedAt: String
    /// User confirmation status, true if the user has joined the team or false otherwise.
    public let confirm: Bool
    /// Date, the user has been invited to join the team in ISO 8601 format.
    public let invited: String
    /// Date, the user has accepted the invitation to join the team in ISO 8601 format.
    public let joined: String
    /// Multi factor authentication status, true if the user has MFA enabled or false otherwise. Hide this attribute by toggling membership privacy in the Console.
    public let mfa: Bool
    /// User list of roles
    public let roles: [String]
    /// Team ID.
    public let teamId: String
    /// Team name.
    public let teamName: String
    /// User email address. Hide this attribute by toggling membership privacy in the Console.
    public let userEmail: String
    /// User ID.
    public let userId: String
    /// User name. Hide this attribute by toggling membership privacy in the Console.
    public let userName: String

    init(
        createdAt: String,
        id: String,
        updatedAt: String,
        confirm: Bool,
        invited: String,
        joined: String,
        mfa: Bool,
        roles: [String],
        teamId: String,
        teamName: String,
        userEmail: String,
        userId: String,
        userName: String
    ) {
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.confirm = confirm
        self.invited = invited
        self.joined = joined
        self.mfa = mfa
        self.roles = roles
        self.teamId = teamId
        self.teamName = teamName
        self.userEmail = userEmail
        self.userId = userId
        self.userName = userName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.confirm = try container.decode(Bool.self, forKey: .confirm)
        self.invited = try container.decode(String.self, forKey: .invited)
        self.joined = try container.decode(String.self, forKey: .joined)
        self.mfa = try container.decode(Bool.self, forKey: .mfa)
        self.roles = try container.decode([String].self, forKey: .roles)
        self.teamId = try container.decode(String.self, forKey: .teamId)
        self.teamName = try container.decode(String.self, forKey: .teamName)
        self.userEmail = try container.decode(String.self, forKey: .userEmail)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userName = try container.decode(String.self, forKey: .userName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(id, forKey: .id)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(confirm, forKey: .confirm)
        try container.encode(invited, forKey: .invited)
        try container.encode(joined, forKey: .joined)
        try container.encode(mfa, forKey: .mfa)
        try container.encode(roles, forKey: .roles)
        try container.encode(teamId, forKey: .teamId)
        try container.encode(teamName, forKey: .teamName)
        try container.encode(userEmail, forKey: .userEmail)
        try container.encode(userId, forKey: .userId)
        try container.encode(userName, forKey: .userName)
    }

    public func toMap() -> [String: Any] {
        return [
            "$createdAt": createdAt as Any,
            "$id": id as Any,
            "$updatedAt": updatedAt as Any,
            "confirm": confirm as Any,
            "invited": invited as Any,
            "joined": joined as Any,
            "mfa": mfa as Any,
            "roles": roles as Any,
            "teamId": teamId as Any,
            "teamName": teamName as Any,
            "userEmail": userEmail as Any,
            "userId": userId as Any,
            "userName": userName as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Membership {
        return Membership(
            createdAt: map["$createdAt"] as! String,
            id: map["$id"] as! String,
            updatedAt: map["$updatedAt"] as! String,
            confirm: map["confirm"] as! Bool,
            invited: map["invited"] as! String,
            joined: map["joined"] as! String,
            mfa: map["mfa"] as! Bool,
            roles: map["roles"] as! [String],
            teamId: map["teamId"] as! String,
            teamName: map["teamName"] as! String,
            userEmail: map["userEmail"] as! String,
            userId: map["userId"] as! String,
            userName: map["userName"] as! String
        )
    }
}
