import Foundation
import JSONCodable

/// 
open class ReorderScanEmit: Codable {

    enum CodingKeys: String, CodingKey {
        case event_id = "event_id"
        case stock_level_id = "stock_level_id"
    }

    /// The event id on the bus. Stable per (row, day), which is what makes a re-run harmless.
    public let event_id: String
    /// The stock row the event is about.
    public let stock_level_id: String

    init(
        event_id: String,
        stock_level_id: String
    ) {
        self.event_id = event_id
        self.stock_level_id = stock_level_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.event_id = try container.decode(String.self, forKey: .event_id)
        self.stock_level_id = try container.decode(String.self, forKey: .stock_level_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(event_id, forKey: .event_id)
        try container.encode(stock_level_id, forKey: .stock_level_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "event_id": event_id as Any,
            "stock_level_id": stock_level_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReorderScanEmit {
        return ReorderScanEmit(
            event_id: map["event_id"] as! String,
            stock_level_id: map["stock_level_id"] as! String
        )
    }
}
