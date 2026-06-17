import Foundation
import JSONCodable

/// Register a return against the shipped quantities — the return number is drawn from the &#039;return&#039; range.
open class OrderReturnCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case positions = "positions"
        case reason = "reason"
    }

    /// Free-form metadata.
    public let metadata: [String: AnyCodable]?
    /// 
    public let positions: [OrderReturnPosition]
    /// 
    public let reason: String?

    init(
        metadata: [String: AnyCodable]?,
        positions: [OrderReturnPosition],
        reason: String?
    ) {
        self.metadata = metadata
        self.positions = positions
        self.reason = reason
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.positions = try container.decode([OrderReturnPosition].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
    }

    public func toMap() -> [String: Any] {
        return [
            "metadata": metadata as Any,
            "positions": positions.map { $0.toMap() } as Any,
            "reason": reason as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnCreateRequest {
        return OrderReturnCreateRequest(
            metadata: map["metadata"] as? [String: AnyCodable],
            positions: (map["positions"] as! [[String: Any]]).map { OrderReturnPosition.from(map: $0) },
            reason: map["reason"] as? String
        )
    }
}
