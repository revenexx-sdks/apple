import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class FormDeleteResult: Codable {

    enum CodingKeys: String, CodingKey {
        case archived = "archived"
        case deleted = "deleted"
        case id = "id"
        case status = "status"
        case submissions = "submissions"
    }

    /// True when the policy is 'archive' and submissions exist — the form was archived, not deleted.
    public let archived: Bool?
    /// The form row was removed — and with it, via the cascade, every submission it had. `submissions` below says how many went, and they are not recoverable.
    public let deleted: Bool?
    /// The form in the path.
    public let id: String?
    /// The form's status after the call. Only present on the archive branch.
    public let status: RevenexxEnums.FormStatus?
    /// How many submissions the form had when the call was weighed — and therefore, when `deleted` is true, how many were deleted with it. The whole inbox, across every market: the cascade is a database operation and takes them all, so an active `X-Revenexx-Market` does not narrow this number.
    public let submissions: Int?

    init(
        archived: Bool?,
        deleted: Bool?,
        id: String?,
        status: RevenexxEnums.FormStatus?,
        submissions: Int?
    ) {
        self.archived = archived
        self.deleted = deleted
        self.id = id
        self.status = status
        self.submissions = submissions
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.archived = try container.decodeIfPresent(Bool.self, forKey: .archived)
        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.FormStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.submissions = try container.decodeIfPresent(Int.self, forKey: .submissions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(archived, forKey: .archived)
        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
        try container.encodeIfPresent(submissions, forKey: .submissions)
    }

    public func toMap() -> [String: Any] {
        return [
            "archived": archived as Any,
            "deleted": deleted as Any,
            "id": id as Any,
            "status": status?.rawValue as Any,
            "submissions": submissions as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FormDeleteResult {
        return FormDeleteResult(
            archived: map["archived"] as? Bool,
            deleted: map["deleted"] as? Bool,
            id: map["id"] as? String,
            status: map["status"] as? String != nil ? FormStatus(rawValue: map["status"] as! String) : nil,
            submissions: map["submissions"] as? Int
        )
    }
}
