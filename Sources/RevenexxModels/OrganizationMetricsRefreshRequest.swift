import Foundation
import JSONCodable

/// 
open class OrganizationMetricsRefreshRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case as_of = "as_of"
        case cursor = "cursor"
        case organization_ids = "organization_ids"
    }

    /// Anchor for the rolling windows — pass back the value the previous call returned.
    public let as_of: String?
    /// Continue an unfinished refresh: the value the previous call returned, verbatim. It is the id of the last organization processed, so only a value this API handed out ever resolves.
    public let cursor: String?
    /// Refresh exactly these organizations in one call instead of walking all of them.
    public let organization_ids: [String]?

    init(
        as_of: String?,
        cursor: String?,
        organization_ids: [String]?
    ) {
        self.as_of = as_of
        self.cursor = cursor
        self.organization_ids = organization_ids
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.as_of = try container.decodeIfPresent(String.self, forKey: .as_of)
        self.cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
        self.organization_ids = try container.decodeIfPresent([String].self, forKey: .organization_ids)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(as_of, forKey: .as_of)
        try container.encodeIfPresent(cursor, forKey: .cursor)
        try container.encodeIfPresent(organization_ids, forKey: .organization_ids)
    }

    public func toMap() -> [String: Any] {
        return [
            "as_of": as_of as Any,
            "cursor": cursor as Any,
            "organization_ids": organization_ids as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrganizationMetricsRefreshRequest {
        return OrganizationMetricsRefreshRequest(
            as_of: map["as_of"] as? String,
            cursor: map["cursor"] as? String,
            organization_ids: map["organization_ids"] as? [String]
        )
    }
}
