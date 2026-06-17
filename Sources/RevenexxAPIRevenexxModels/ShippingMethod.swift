import Foundation
import JSONCodable

/// 
open class ShippingMethod: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case code = "code"
        case countries = "countries"
        case created_at = "created_at"
        case currency = "currency"
        case description = "description"
        case enabled = "enabled"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case free_above = "free_above"
        case id = "id"
        case labels = "labels"
        case matrix_attribute = "matrix_attribute"
        case matrix_basis = "matrix_basis"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case price = "price"
        case pricing_type = "pricing_type"
        case tax_class = "tax_class"
        case updated_at = "updated_at"
    }

    /// 
    public let carrier: String?
    /// 
    public let code: String?
    /// 
    public let countries: [String: AnyCodable]?
    /// 
    public let created_at: String?
    /// 
    public let currency: String?
    /// 
    public let description: String?
    /// 
    public let enabled: Bool?
    /// 
    public let eta_days_max: Int?
    /// 
    public let eta_days_min: Int?
    /// 
    public let free_above: Double?
    /// 
    public let id: String?
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let matrix_attribute: String?
    /// 
    public let matrix_basis: String?
    /// 
    public let metadata: [String: AnyCodable]?
    /// 
    public let name: String?
    /// 
    public let position: Int?
    /// 
    public let price: Double?
    /// 
    public let pricing_type: String?
    /// 
    public let tax_class: String?
    /// 
    public let updated_at: String?

    init(
        carrier: String?,
        code: String?,
        countries: [String: AnyCodable]?,
        created_at: String?,
        currency: String?,
        description: String?,
        enabled: Bool?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        free_above: Double?,
        id: String?,
        labels: [String: AnyCodable]?,
        matrix_attribute: String?,
        matrix_basis: String?,
        metadata: [String: AnyCodable]?,
        name: String?,
        position: Int?,
        price: Double?,
        pricing_type: String?,
        tax_class: String?,
        updated_at: String?
    ) {
        self.carrier = carrier
        self.code = code
        self.countries = countries
        self.created_at = created_at
        self.currency = currency
        self.description = description
        self.enabled = enabled
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.free_above = free_above
        self.id = id
        self.labels = labels
        self.matrix_attribute = matrix_attribute
        self.matrix_basis = matrix_basis
        self.metadata = metadata
        self.name = name
        self.position = position
        self.price = price
        self.pricing_type = pricing_type
        self.tax_class = tax_class
        self.updated_at = updated_at
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decodeIfPresent(String.self, forKey: .carrier)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String: AnyCodable].self, forKey: .countries)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.free_above = try container.decodeIfPresent(Double.self, forKey: .free_above)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.matrix_attribute = try container.decodeIfPresent(String.self, forKey: .matrix_attribute)
        self.matrix_basis = try container.decodeIfPresent(String.self, forKey: .matrix_basis)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.pricing_type = try container.decodeIfPresent(String.self, forKey: .pricing_type)
        self.tax_class = try container.decodeIfPresent(String.self, forKey: .tax_class)
        self.updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(carrier, forKey: .carrier)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(free_above, forKey: .free_above)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(matrix_attribute, forKey: .matrix_attribute)
        try container.encodeIfPresent(matrix_basis, forKey: .matrix_basis)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(pricing_type, forKey: .pricing_type)
        try container.encodeIfPresent(tax_class, forKey: .tax_class)
        try container.encodeIfPresent(updated_at, forKey: .updated_at)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "code": code as Any,
            "countries": countries as Any,
            "created_at": created_at as Any,
            "currency": currency as Any,
            "description": description as Any,
            "enabled": enabled as Any,
            "eta_days_max": eta_days_max as Any,
            "eta_days_min": eta_days_min as Any,
            "free_above": free_above as Any,
            "id": id as Any,
            "labels": labels as Any,
            "matrix_attribute": matrix_attribute as Any,
            "matrix_basis": matrix_basis as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "price": price as Any,
            "pricing_type": pricing_type as Any,
            "tax_class": tax_class as Any,
            "updated_at": updated_at as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingMethod {
        return ShippingMethod(
            carrier: map["carrier"] as? String,
            code: map["code"] as? String,
            countries: map["countries"] as? [String: AnyCodable],
            created_at: map["created_at"] as? String,
            currency: map["currency"] as? String,
            description: map["description"] as? String,
            enabled: map["enabled"] as? Bool,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            free_above: map["free_above"] as? Double,
            id: map["id"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            matrix_attribute: map["matrix_attribute"] as? String,
            matrix_basis: map["matrix_basis"] as? String,
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as? String,
            position: map["position"] as? Int,
            price: map["price"] as? Double,
            pricing_type: map["pricing_type"] as? String,
            tax_class: map["tax_class"] as? String,
            updated_at: map["updated_at"] as? String
        )
    }
}
