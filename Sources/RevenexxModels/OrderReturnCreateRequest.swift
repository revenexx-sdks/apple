import Foundation
import JSONCodable

/// Register a return against the shipped quantities — the return number is drawn from the return range. Omitted positions = every position that still has a returnable quantity, in full ('the customer sent it all back').
open class OrderReturnCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case positions = "positions"
        case reason = "reason"
        case restock = "restock"
    }

    /// Free-form data for the caller — the returns portal's own reference. Stored and returned untouched.
    public let metadata: [String: AnyCodable]?
    /// What is coming back. Omitted = every position with a returnable (shipped, not yet returned) quantity, in full.
    public let positions: [OrderReturnPosition]?
    /// Why the goods are coming back, free text as the customer or the desk stated it. Also what /reject stores when it is given no resolution out of the published set.
    public let reason: String?
    /// The default restock flag for positions that carry none of their own — and the only way to say "put it all back into stock" when the positions are defaulted. It does not restock anything itself: it decides what the completion REPORTS for the orchestrator's inventories.restock call.
    public let restock: Bool?

    init(
        metadata: [String: AnyCodable]?,
        positions: [OrderReturnPosition]?,
        reason: String?,
        restock: Bool?
    ) {
        self.metadata = metadata
        self.positions = positions
        self.reason = reason
        self.restock = restock
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.positions = try container.decodeIfPresent([OrderReturnPosition].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.restock = try container.decodeIfPresent(Bool.self, forKey: .restock)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(restock, forKey: .restock)
    }

    public func toMap() -> [String: Any] {
        return [
            "metadata": metadata as Any,
            "positions": positions?.map { $0.toMap() } as Any,
            "reason": reason as Any,
            "restock": restock as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnCreateRequest {
        return OrderReturnCreateRequest(
            metadata: map["metadata"] as? [String: AnyCodable],
            positions: (map["positions"] as? [[String: Any]] ?? []).map { OrderReturnPosition.from(map: $0) },
            reason: map["reason"] as? String,
            restock: map["restock"] as? Bool
        )
    }
}
