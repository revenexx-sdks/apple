import Foundation
import JSONCodable
import RevenexxEnums

/// Partial update — omitted fields keep their current value.
open class SegmentMemberUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case organization_id = "organization_id"
        case segment_id = "segment_id"
        case source = "source"
    }

    /// The member company. Segments group companies, never people — a person is reached through their organization.
    public let organization_id: String?
    /// The segment.
    public let segment_id: String?
    /// How this membership came about: 'manual' is hand-picked, 'rule' was materialized by a recompute. The distinction is load-bearing — a recompute only ever inserts and deletes 'rule' rows, so a hand-picked member survives every rule change. Default 'manual'.
    public let source: RevenexxEnums.SegmentMemberSource?

    init(
        organization_id: String?,
        segment_id: String?,
        source: RevenexxEnums.SegmentMemberSource?
    ) {
        self.organization_id = organization_id
        self.segment_id = segment_id
        self.source = source
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.organization_id = try container.decodeIfPresent(String.self, forKey: .organization_id)
        self.segment_id = try container.decodeIfPresent(String.self, forKey: .segment_id)
        if let sourceString = try container.decodeIfPresent(String.self, forKey: .source) {
            self.source = RevenexxEnums.SegmentMemberSource(rawValue: sourceString)
        } else {
            self.source = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(organization_id, forKey: .organization_id)
        try container.encodeIfPresent(segment_id, forKey: .segment_id)
        try container.encodeIfPresent(source?.rawValue, forKey: .source)
    }

    public func toMap() -> [String: Any] {
        return [
            "organization_id": organization_id as Any,
            "segment_id": segment_id as Any,
            "source": source?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> SegmentMemberUpdateRequest {
        return SegmentMemberUpdateRequest(
            organization_id: map["organization_id"] as? String,
            segment_id: map["segment_id"] as? String,
            source: map["source"] as? String != nil ? SegmentMemberSource(rawValue: map["source"] as! String) : nil
        )
    }
}
