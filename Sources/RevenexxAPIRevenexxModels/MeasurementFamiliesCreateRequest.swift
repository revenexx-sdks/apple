import Foundation
import JSONCodable

/// 
open class MeasurementFamiliesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case standard_unit = "standard_unit"
        case units = "units"
    }

    /// 
    public let code: String
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let standard_unit: String
    /// 
    public let units: [String: AnyCodable]?

    init(
        code: String,
        labels: [String: AnyCodable]?,
        standard_unit: String,
        units: [String: AnyCodable]?
    ) {
        self.code = code
        self.labels = labels
        self.standard_unit = standard_unit
        self.units = units
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.standard_unit = try container.decode(String.self, forKey: .standard_unit)
        self.units = try container.decodeIfPresent([String: AnyCodable].self, forKey: .units)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encode(standard_unit, forKey: .standard_unit)
        try container.encodeIfPresent(units, forKey: .units)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "standard_unit": standard_unit as Any,
            "units": units as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MeasurementFamiliesCreateRequest {
        return MeasurementFamiliesCreateRequest(
            code: map["code"] as! String,
            labels: map["labels"] as? [String: AnyCodable],
            standard_unit: map["standard_unit"] as! String,
            units: map["units"] as? [String: AnyCodable]
        )
    }
}
