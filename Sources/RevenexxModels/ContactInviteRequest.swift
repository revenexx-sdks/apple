import Foundation
import JSONCodable

/// 
open class ContactInviteRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case invited_by = "invited_by"
        case url = "url"
    }

    /// Who did the inviting, as the recipient should read it. Absent, the company name is used — "Beispiel GmbH invited you" reads better than the name of somebody they have never heard of.
    public let invited_by: String?
    /// Where the invitation points — the storefront sign-in, normally. There is no token in it: the person is already a member and only has to sign in.
    public let url: String

    init(
        invited_by: String?,
        url: String
    ) {
        self.invited_by = invited_by
        self.url = url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.invited_by = try container.decodeIfPresent(String.self, forKey: .invited_by)
        self.url = try container.decode(String.self, forKey: .url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(invited_by, forKey: .invited_by)
        try container.encode(url, forKey: .url)
    }

    public func toMap() -> [String: Any] {
        return [
            "invited_by": invited_by as Any,
            "url": url as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ContactInviteRequest {
        return ContactInviteRequest(
            invited_by: map["invited_by"] as? String,
            url: map["url"] as! String
        )
    }
}
