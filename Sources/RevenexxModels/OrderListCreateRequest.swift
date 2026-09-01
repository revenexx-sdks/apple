import Foundation
import JSONCodable

/// 
open class OrderListCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case kind = "kind"
        case metadata = "metadata"
        case name = "name"
        case organization_id = "organization_id"
        case owner_id = "owner_id"
        case owner_name = "owner_name"
        case shared = "shared"
    }

    /// Optional initial positions. Every one is validated — and article-checked where `reject_unknown_articles` is on — BEFORE the list row is written, so a rejected position never leaves an empty list behind.
    public let items: [OrderListItemInput]?
    /// List kind — the `code` of one of the tenant's own kinds (GET /orderlists/kinds); defaults to the flagged one, or the market's 'default_kind' setting.
    public let kind: String?
    /// Free-form data the tenant keeps on the list — an ERP requisition number, a department, whatever an integration needs to recognise the list again. Never read by this app, and never merged: a write replaces the whole document.
    public let metadata: [String: AnyCodable]?
    /// What the buyer calls this list. Free text, at least one character, and not unique: two contacts may both keep a "Weekly office supplies". It is also the name a NEW cart gets when POST /orderlists/{id}/cart creates one.
    public let name: String
    /// The organization the sharing is scoped to. Null means the list can only ever be the owner's own: `shared` is meaningless without it, because there is no set of people to share with. It is also what the order conversion hands the orders app as the buying organization.
    public let organization_id: String?
    /// The contact who owns the list. Ownership IS the authorization here: a caller the gateway resolved to a contact sees their own lists plus their organization's shared ones, and may write only their own — unless `shared_lists_editable` opens a shared list to the whole owning organization. Set once at create; no route moves a list to another owner.
    public let owner_id: String
    /// The owner's display name as it stood when the list was created — a snapshot, so renaming the contact does not rewrite it. Carried so a shared list can say whose it is without a call to the contacts app.
    public let owner_name: String
    /// Whether the OWNING ORGANIZATION may see this list. False — the default — keeps it private to `owner_id`, and a foreign private list answers 404 rather than 403, so an outsider learns nothing from the difference. True lets every contact of `organization_id` READ it, and write it only where the tenant turned on the `shared_lists_editable` setting. A list with no `organization_id` shares with nobody however this is set.
    public let shared: Bool?

    init(
        items: [OrderListItemInput]?,
        kind: String?,
        metadata: [String: AnyCodable]?,
        name: String,
        organization_id: String?,
        owner_id: String,
        owner_name: String,
        shared: Bool?
    ) {
        self.items = items
        self.kind = kind
        self.metadata = metadata
        self.name = name
        self.organization_id = organization_id
        self.owner_id = owner_id
        self.owner_name = owner_name
        self.shared = shared
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decodeIfPresent([OrderListItemInput].self, forKey: .items)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decode(String.self, forKey: .name)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.owner_id = try container.decode(String.self, forKey: .owner_id)
        self.owner_name = try container.decode(String.self, forKey: .owner_name)
        self.shared = try container.decodeIfPresent(Bool.self, forKey: .shared)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encode(owner_id, forKey: .owner_id)
        try container.encode(owner_name, forKey: .owner_name)
        try container.encodeIfPresent(shared, forKey: .shared)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items?.map { $0.toMap() } as Any,
            "kind": kind as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "organization_id": organization_id as Any,
            "owner_id": owner_id as Any,
            "owner_name": owner_name as Any,
            "shared": shared as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderListCreateRequest {
        return OrderListCreateRequest(
            items: (map["items"] as? [[String: Any]] ?? []).map { OrderListItemInput.from(map: $0) },
            kind: map["kind"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as! String,
            organization_id: map["organization_id"] as? String,
            owner_id: map["owner_id"] as! String,
            owner_name: map["owner_name"] as! String,
            shared: map["shared"] as? Bool
        )
    }
}
