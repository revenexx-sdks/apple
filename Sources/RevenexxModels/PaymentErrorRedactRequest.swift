import Foundation
import JSONCodable

/// 
open class PaymentErrorRedactRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case apply = "apply"
        case limit = "limit"
    }

    /// Write the reclassified values. Defaults to false, which reports what WOULD change and touches nothing.
    public let apply: Bool?
    /// How many payments to scan, oldest first. Defaults to 500, capped at 5000 — a tenant with more pre-taxonomy rows needs several runs, and re-running is free.
    public let limit: Int?

    init(
        apply: Bool?,
        limit: Int?
    ) {
        self.apply = apply
        self.limit = limit
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.apply = try container.decodeIfPresent(Bool.self, forKey: .apply)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apply, forKey: .apply)
        try container.encodeIfPresent(limit, forKey: .limit)
    }

    public func toMap() -> [String: Any] {
        return [
            "apply": apply as Any,
            "limit": limit as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PaymentErrorRedactRequest {
        return PaymentErrorRedactRequest(
            apply: map["apply"] as? Bool,
            limit: map["limit"] as? Int
        )
    }
}
