import Foundation
import JSONCodable

/// Partial update — rename, visibility or kind. Positions go through the items routes, and the owner cannot be changed.
open class OrderListUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case metadata = "metadata"
        case name = "name"
        case shared = "shared"
    }

    /// List kind — the `code` of one of the tenant's own kinds (GET /orderlists/kinds); defaults to the flagged one, or the market's 'default_kind' setting.
    public let kind: String?
    /// Free-form data the tenant keeps on the list — an ERP requisition number, a department, whatever an integration needs to recognise the list again. Never read by this app, and never merged: a write replaces the whole document.
    public let metadata: [String: AnyCodable]?
    /// What the buyer calls this list. Free text, at least one character, and not unique: two contacts may both keep a "Weekly office supplies". It is also the name a NEW cart gets when POST /orderlists/{id}/cart creates one.
    public let name: String?
    /// Whether the OWNING ORGANIZATION may see this list. False — the default — keeps it private to `owner_id`, and a foreign private list answers 404 rather than 403, so an outsider learns nothing from the difference. True lets every contact of `organization_id` READ it, and write it only where the tenant turned on the `shared_lists_editable` setting. A list with no `organization_id` shares with nobody however this is set.
    public let shared: Bool?

    init(
        kind: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        shared: Bool?
    ) {
        self.kind = kind
        self.metadata = metadata
        self.name = name
        self.shared = shared
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.shared = try container.decodeIfPresent(Bool.self, forKey: .shared)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(shared, forKey: .shared)
    }

    public func toMap() -> [String: Any] {
        return [
            "kind": kind as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "shared": shared as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListUpdateRequest {
        return OrderListUpdateRequest(
            kind: map["kind"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            shared: map["shared"] as? Bool
        )
    }
}
