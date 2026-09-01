import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class LocationCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case address = "address"
        case code = "code"
        case enabled = "enabled"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case priority = "priority"
        case type = "type"
    }

    /// Where the location physically is. Free-form, and one key is READ: `country`, an ISO country code, which POST /inventories/reserve compares (case-insensitively) against `ship_to.country` when `allocation_strategy` is 'nearest' — that is what stops a German order pulling from the US warehouse because it happens to sort first. The keys the cockpit form writes are `street`, `postal_code`, `city`, `country`; anything else a tenant stores is kept and ignored.
    public let address: [String: AnyCodable]?
    /// The location's stable identifier, and the name every stock call uses instead of an id: `location_code` on receive / adjust / restock / reserve, and the `default_location_code` setting. Unique per tenant, at least one character (CHECK `length(code) > 0`). Every tenant starts with `main` — POST /inventories/locations/defaults seeds it and the app.installed event runs the same seed — so `main` is the one code that resolves everywhere.
    public let code: String
    /// Whether this location takes part in stock at all. POST /inventories/availability and POST /inventories/reserve look at enabled locations and nothing else, so switching this off hides a location's stock from the storefront without deleting a row or losing a single ledger booking; its stock stays readable through GET /inventories/stock. Defaults to true.
    public let enabled: Bool?
    /// The location name per language tag, for a UI that has to render it in the reader's language. Falls back to `name` when a tag is missing. Keys are language tags, values plain strings.
    public let labels: [String: AnyCodable]?
    /// Free-form data the tenant keeps on the location — an ERP site number, a contact, a cut-off time. No route in this app reads it; it is stored and handed back unchanged.
    public let metadata: [String: AnyCodable]?
    /// What the place is called for an operator, in the tenant's working language. At least one character (CHECK `length(name) > 0`). It is a label only: nothing addresses a location by name.
    public let name: String
    /// Sourcing order for POST /inventories/reserve while `allocation_strategy` is 'priority': the enabled locations are walked ASCENDING and the first that can cover the item wins, so a LOWER number is preferred. Locations that tie keep the order the database returns them in — give every location a distinct priority if the order matters. Defaults to 0.
    public let priority: Int?
    /// What kind of place holds the stock. 'warehouse' — own stock, the default. 'store' — a retail floor, the stock a click-and-collect order draws on. 'dropship' — a supplier ships it and this row tracks what they say they hold. 'virtual' — a bucket that is not a building (pre-orders, consignment, a quarantine shelf). Descriptive only: sourcing order comes from `priority`, and no route in this app treats one type differently from another. Defaults to 'warehouse'.
    public let type: RevenexxEnums.LocationType?

    init(
        address: [String: AnyCodable]?,
        code: String,
        enabled: Bool?,
        labels: [String: AnyCodable]?,
        metadata: [String: AnyCodable]?,
        name: String,
        priority: Int?,
        type: RevenexxEnums.LocationType?
    ) {
        self.address = address
        self.code = code
        self.enabled = enabled
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.priority = priority
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.address = try container.decodeIfPresent([String: AnyCodable].self, forKey: .address)
        self.code = try container.decode(String.self, forKey: .code)
        self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decode(String.self, forKey: .name)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority)
        if let typeString = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = RevenexxEnums.LocationType(rawValue: typeString)
        } else {
            self.type = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(address, forKey: .address)
        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "address": address as Any,
            "code": code as Any,
            "enabled": enabled as Any,
            "labels": labels as Any,
            "metadata": metadata as Any,
            "name": name as Any,
            "priority": priority as Any,
            "type": type?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> LocationCreateRequest {
        return LocationCreateRequest(
            address: map["address"] as? [String: AnyCodable],
            code: map["code"] as! String,
            enabled: map["enabled"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as! String,
            priority: map["priority"] as? Int,
            type: map["type"] as? String != nil ? LocationType(rawValue: map["type"] as! String) : nil
        )
    }
}
