import Foundation
import JSONCodable

/// Metric
open class Metric: Codable {

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case value = "value"
    }

    /// The date at which this metric was aggregated in ISO 8601 format.
    public let date: String
    /// The value of this metric at the timestamp.
    public let value: Int

    init(
        date: String,
        value: Int
    ) {
        self.date = date
        self.value = value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.date = try container.decode(String.self, forKey: .date)
        self.value = try container.decode(Int.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(date, forKey: .date)
        try container.encode(value, forKey: .value)
    }

    public func toMap() -> [String: Any] {
        return [
            "date": date as Any,
            "value": value as Any
        ]
    }

    public static func from(map: [String: Any] ) -> Metric {
        return Metric(
            date: map["date"] as! String,
            value: map["value"] as! Int
        )
    }
}
