import Foundation
import JSONCodable

/// 
open class InventoryAvailabilityRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case location_code = "location_code"
    }

    /// The items to check (batch, at most 200).
    public let items: [InventoryAvailabilityItem]
    /// Restrict the check to one location (default: all enabled locations).
    public let location_code: String?

    init(
        items: [InventoryAvailabilityItem],
        location_code: String?
    ) {
        self.items = items
        self.location_code = location_code
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([InventoryAvailabilityItem].self, forKey: .items)
        self.location_code = try container.decodeIfPresent(String.self, forKey: .location_code)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(items, forKey: .items)
        try container.encodeIfPresent(location_code, forKey: .location_code)
    }

    public func toMap() -> [String: Any] {
        return [
            "items": items.map { $0.toMap() } as Any,
            "location_code": location_code as Any
        ]
    }

    public static func from(map: [String: Any] ) -> InventoryAvailabilityRequest {
        return InventoryAvailabilityRequest(
            items: (map["items"] as! [[String: Any]]).map { InventoryAvailabilityItem.from(map: $0) },
            location_code: map["location_code"] as? String
        )
    }
}
