import Foundation
import JSONCodable

/// 
open class OrderReturn: Codable {

    enum CodingKeys: String, CodingKey {
        case completed_at = "completed_at"
        case created_at = "created_at"
        case id = "id"
        case metadata = "metadata"
        case number = "number"
        case order_id = "order_id"
        case positions = "positions"
        case reason = "reason"
        case received_at = "received_at"
        case registered_at = "registered_at"
        case rejected_at = "rejected_at"
        case resolution = "resolution"
        case status = "status"
        case updated_at = "updated_at"
    }

    /// 
    public let completed_at: String?
    /// 
    public let created_at: String?
    /// 
    public let id: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let number: String?
    /// 
    public let order_id: String?
    /// 
    public let positions: [String: AnyCodable]?
    /// 
    public let reason: String?
    /// 
    public let received_at: String?
    /// 
    public let registered_at: String?
    /// 
    public let rejected_at: String?
    /// 
    public let resolution: String?
    /// 
    public let status: String?
    /// 
    public let updated_at: String?

    init(
        completed_at: String?,
        created_at: String?,
        id: String?,
        metadata: [String: AnyCodable]?,
        number: String?,
        order_id: String?,
        positions: [String: AnyCodable]?,
        reason: String?,
        received_at: String?,
        registered_at: String?,
        rejected_at: String?,
        resolution: String?,
        status: String?,
        updated_at: String?
    ) {
        self.completed_at = completed_at
        self.created_at = created_at
        self.id = id
        self.metadata = metadata
        self.number = number
        self.order_id = order_id
        self.positions = positions
        self.reason = reason
        self.received_at = received_at
        self.registered_at = registered_at
        self.rejected_at = rejected_at
        self.resolution = resolution
        self.status = status
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.completed_at = try container.decodeIfPresent(String.self, forKey: .completed_at)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.order_id = try container.decodeIfPresent(String.self, forKey: .order_id)
        self.positions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .positions)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.received_at = try container.decodeIfPresent(String.self, forKey: .received_at)
        self.registered_at = try container.decodeIfPresent(String.self, forKey: .registered_at)
        self.rejected_at = try container.decodeIfPresent(String.self, forKey: .rejected_at)
        self.resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(completed_at, forKey: .completed_at)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(number, forKey: .number)
        try container.encodeIfPresent(order_id, forKey: .order_id)
        try container.encodeIfPresent(positions, forKey: .positions)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(received_at, forKey: .received_at)
        try container.encodeIfPresent(registered_at, forKey: .registered_at)
        try container.encodeIfPresent(rejected_at, forKey: .rejected_at)
        try container.encodeIfPresent(resolution, forKey: .resolution)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "completed_at": completed_at as Any,
            "created_at": created_at as Any,
            "id": id as Any,
            "metadata": metadata as Any,
            "number": number as Any,
            "order_id": order_id as Any,
            "positions": positions as Any,
            "reason": reason as Any,
            "received_at": received_at as Any,
            "registered_at": registered_at as Any,
            "rejected_at": rejected_at as Any,
            "resolution": resolution as Any,
            "status": status as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturn {
        return OrderReturn(
            completed_at: map["completed_at"] as? String,
            created_at: map["created_at"] as? String,
            id: map["id"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            number: map["number"] as? String,
            order_id: map["order_id"] as? String,
            positions: map["positions"] as? [String: AnyCodable],
            reason: map["reason"] as? String,
            received_at: map["received_at"] as? String,
            registered_at: map["registered_at"] as? String,
            rejected_at: map["rejected_at"] as? String,
            resolution: map["resolution"] as? String,
            status: map["status"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
