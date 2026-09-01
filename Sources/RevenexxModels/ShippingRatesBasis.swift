import Foundation
import JSONCodable
import RevenexxEnums

/// How this answer was measured — the tenant settings that shaped it, echoed so the numbers can be re-derived.
open class ShippingRatesBasis: Codable {

    enum CodingKeys: String, CodingKey {
        case evaluated_at = "evaluated_at"
        case free_above_compares = "free_above_compares"
        case matrix_basis_default = "matrix_basis_default"
        case request_weight_unit = "request_weight_unit"
        case request_weight_unit_factor = "request_weight_unit_factor"
        case weight_unit = "weight_unit"
        case weight_unit_factor = "weight_unit_factor"
    }

    /// The instant the delivery estimates were computed from.
    public let evaluated_at: String?
    /// Whether free-above thresholds were compared against the net or the gross order value.
    public let free_above_compares: RevenexxEnums.ShippingFreeAboveBasis?
    /// The measure a matrix method without its own basis priced over.
    public let matrix_basis_default: RevenexxEnums.ShippingRatesBasisMatrixBasisDefault?
    /// The unit the request expressed its weight in; converted to weight_unit before any tier was matched.
    public let request_weight_unit: String?
    /// Kilograms per unit of `request_weight_unit`, as applied.
    public let request_weight_unit_factor: Double?
    /// The unit the rate tiers are keyed in — this market's `weight_unit` setting, else the unit the tenant flagged as default.
    public let weight_unit: String?
    /// Kilograms per unit of `weight_unit`, as applied. Echoed because a unit is a code PLUS a number and the number is what priced the parcel — a quote has to be re-derivable from its own payload, not from a table the merchant may since have edited.
    public let weight_unit_factor: Double?

    init(
        evaluated_at: String?,
        free_above_compares: RevenexxEnums.ShippingFreeAboveBasis?,
        matrix_basis_default: RevenexxEnums.ShippingRatesBasisMatrixBasisDefault?,
        request_weight_unit: String?,
        request_weight_unit_factor: Double?,
        weight_unit: String?,
        weight_unit_factor: Double?
    ) {
        self.evaluated_at = evaluated_at
        self.free_above_compares = free_above_compares
        self.matrix_basis_default = matrix_basis_default
        self.request_weight_unit = request_weight_unit
        self.request_weight_unit_factor = request_weight_unit_factor
        self.weight_unit = weight_unit
        self.weight_unit_factor = weight_unit_factor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.evaluated_at = try container.decodeIfPresent(String.self, forKey: .evaluated_at)
        if let free_above_comparesString = try container.decodeIfPresent(String.self, forKey: .free_above_compares) {
            self.free_above_compares = RevenexxEnums.ShippingFreeAboveBasis(rawValue: free_above_comparesString)
        } else {
            self.free_above_compares = nil
        }
        if let matrix_basis_defaultString = try container.decodeIfPresent(String.self, forKey: .matrix_basis_default) {
            self.matrix_basis_default = RevenexxEnums.ShippingRatesBasisMatrixBasisDefault(rawValue: matrix_basis_defaultString)
        } else {
            self.matrix_basis_default = nil
        }
        self.request_weight_unit = try container.decodeIfPresent(String.self, forKey: .request_weight_unit)
        self.request_weight_unit_factor = try container.decodeIfPresent(Double.self, forKey: .request_weight_unit_factor)
        self.weight_unit = try container.decodeIfPresent(String.self, forKey: .weight_unit)
        self.weight_unit_factor = try container.decodeIfPresent(Double.self, forKey: .weight_unit_factor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(evaluated_at, forKey: .evaluated_at)
        try container.encodeIfPresent(free_above_compares?.rawValue, forKey: .free_above_compares)
        try container.encodeIfPresent(matrix_basis_default?.rawValue, forKey: .matrix_basis_default)
        try container.encodeIfPresent(request_weight_unit, forKey: .request_weight_unit)
        try container.encodeIfPresent(request_weight_unit_factor, forKey: .request_weight_unit_factor)
        try container.encodeIfPresent(weight_unit, forKey: .weight_unit)
        try container.encodeIfPresent(weight_unit_factor, forKey: .weight_unit_factor)
    }

    public func toMap() -> [String: Any] {
        return [
            "evaluated_at": evaluated_at as Any,
            "free_above_compares": free_above_compares?.rawValue as Any,
            "matrix_basis_default": matrix_basis_default?.rawValue as Any,
            "request_weight_unit": request_weight_unit as Any,
            "request_weight_unit_factor": request_weight_unit_factor as Any,
            "weight_unit": weight_unit as Any,
            "weight_unit_factor": weight_unit_factor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingRatesBasis {
        return ShippingRatesBasis(
            evaluated_at: map["evaluated_at"] as? String,
            free_above_compares: map["free_above_compares"] as? String != nil ? ShippingFreeAboveBasis(rawValue: map["free_above_compares"] as! String) : nil,
            matrix_basis_default: map["matrix_basis_default"] as? String != nil ? ShippingRatesBasisMatrixBasisDefault(rawValue: map["matrix_basis_default"] as! String) : nil,
            request_weight_unit: map["request_weight_unit"] as? String,
            request_weight_unit_factor: map["request_weight_unit_factor"] as? Double,
            weight_unit: map["weight_unit"] as? String,
            weight_unit_factor: map["weight_unit_factor"] as? Double
        )
    }
}
