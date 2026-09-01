import Foundation
import JSONCodable
import RevenexxEnums

/// One organization inside one segment, and the record of how it got there (hand-picked or matched by the rule).
open class SegmentMember: Codable {

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case id = "id"
        case organization_id = "organization_id"
        case segment_id = "segment_id"
        case source = "source"
        case tenant_id = "tenant_id"
    }

    /// When the organization joined the segment.
    public let created_at: String?
    /// Primary key of the membership row.
    public let id: String?
    /// The member company. Segments group companies, never people — a person is reached through their organization.
    public let organization_id: String?
    /// The segment.
    public let segment_id: String?
    /// How this membership came about: 'manual' is hand-picked, 'rule' was materialized by a recompute. The distinction is load-bearing — a recompute only ever inserts and deletes 'rule' rows, so a hand-picked member survives every rule change.
    public let source: RevenexxEnums.SegmentMemberSource?
    /// The tenant this row belongs to — the store slug, not an id. Set by the platform from the authenticated context, never by a caller; a write that carries it is ignored, and no request can read another tenant's rows by sending a different one.
    public let tenant_id: String?

    init(
        created_at: String?,
        id: String?,
        organization_id: String?,
        segment_id: String?,
        source: RevenexxEnums.SegmentMemberSource?,
        tenant_id: String?
    ) {
        self.created_at = created_at
        self.id = id
        self.organization_id = organization_id
        self.segment_id = segment_id
        self.source = source
        self.tenant_id = tenant_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.segment_id = try container.decodeIfPresent(String.self, forKey: .segment_id)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.SegmentMemberSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
        self.tenant_id = try container.decodeIfPresent(String.self, forKey: .tenant_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(segment_id, forKey: .segment_id)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
        try container.encodeIfPresent(tenant_id, forKey: .tenant_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "created_at": created_at as Any,
            "id": id as Any,
            "organization_id": organization_id as Any,
            "segment_id": segment_id as Any,
            "source": source?.rawValue as Any,
            "tenant_id": tenant_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentMember {
        return SegmentMember(
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            organization_id: map["organization_id"] as? String,
            segment_id: map["segment_id"] as? String,
            source: map["source"] as? String != nil ? SegmentMemberSource(rawValue: map["source"] as! String) : nil,
            tenant_id: map["tenant_id"] as? String
        )
    }
}
