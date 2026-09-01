import Foundation
import JSONCodable

/// How long the link should live.
open class PagePreviewGrantRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case ttlHours = "ttlHours"
    }

    /// Hours until the link expires. Defaults to 72. After that `GET /pages/delivery/preview/{token}` answers 410 rather than 404, so the holder can tell "expired" from "wrong link".
    public let ttlHours: Int?

    init(
        ttlHours: Int?
    ) {
        self.ttlHours = ttlHours
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.ttlHours = try container.decodeIfPresent(Int.self, forKey: .ttlHours)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(ttlHours, forKey: .ttlHours)
    }

    public func toMap() -> [String: Any] {
        return [
            "ttlHours": ttlHours as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PagePreviewGrantRequest {
        return PagePreviewGrantRequest(
            ttlHours: map["ttlHours"] as? Int
        )
    }
}
