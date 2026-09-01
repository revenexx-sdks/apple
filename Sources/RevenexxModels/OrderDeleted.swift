import Foundation
import JSONCodable

/// The row is gone. Deleting is not idempotent here: a second call answers 404, because the row no longer resolves.
open class OrderDeleted: Codable {

    enum CodingKeys: String, CodingKey {
        case deleted = "deleted"
        case id = "id"
    }

    /// Always true — a failed delete is a status code, not a false here.
    public let deleted: Bool?
    /// The id of the row that was deleted, echoed back.
    public let id: String?

    init(
        deleted: Bool?,
        id: String?
    ) {
        self.deleted = deleted
        self.id = id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(deleted, forKey: .deleted)
        try container.encodeIfPresent(id, forKey: .id)
    }

    public func toMap() -> [String: Any] {
        return [
            "deleted": deleted as Any,
            "id": id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderDeleted {
        return OrderDeleted(
            deleted: map["deleted"] as? Bool,
            id: map["id"] as? String
        )
    }
}
