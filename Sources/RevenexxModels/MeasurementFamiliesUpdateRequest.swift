import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class MeasurementFamiliesUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case standard_unit = "standard_unit"
        case units = "units"
    }

    /// The measurement family's stable identifier. A `measure` attribute names one and then offers that family's units.
    public let code: String?
    /// What the measurement family is called, per language tag.
    public let labels: [String: AnyCodable]?
    /// The unit every value of this family is converted to before it is compared or sorted — the unit each `convert_factor` is relative to.
    public let standard_unit: String?
    /// The units this family offers. `convert_factor` multiplies a value into `standard_unit`, so a gram is 0.001 kilograms; `symbol` is what a form prints next to the number.
    public let units: [String: AnyCodable]?

    init(
        code: String?,
        labels: [String: AnyCodable]?,
        standard_unit: String?,
        units: [String: AnyCodable]?
    ) {
        self.code = code
        self.labels = labels
        self.standard_unit = standard_unit
        self.units = units
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.standard_unit = try container.decodeIfPresent(String.self, forKey: .standard_unit)
        self.units = try container.decodeIfPresent([String: AnyCodable].self, forKey: .units)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(standard_unit, forKey: .standard_unit)
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

    public static func from(map: [String: Any] ) -> MeasurementFamiliesUpdateRequest {
        return MeasurementFamiliesUpdateRequest(
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            standard_unit: map["standard_unit"] as? String,
            units: map["units"] as? [String: AnyCodable]
        )
    }
}
