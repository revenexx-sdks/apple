import Foundation
import JSONCodable

/// One carrier this app knows the facts for, exactly as it would be created.
open class ShippingCarrierCatalogEntry: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case countries = "countries"
        case cutoff_time = "cutoff_time"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case handling_days = "handling_days"
        case labels = "labels"
        case name = "name"
        case seeded = "seeded"
        case service_level = "service_level"
        case tracking_url_template = "tracking_url_template"
    }

    /// The code the seeded row would carry, and the code a method's `carrier` text has to match to resolve to it.
    public let code: String?
    /// The countries this carrier serves. ISO 3166-1 alpha-2 codes; null or an empty array means no restriction. Compared upper-cased, so a lower-case entry still matches. Declared as an array rather than the bare object a jsonb column derives to — this one is always a list.
    public let countries: [String]?
    /// This carrier's own daily pickup cut-off, HH:MM in 24-hour form, UTC. Overrides the tenant's cutoff_time for methods on this carrier — one shop-wide time cannot be both DHL's 16:00 and a forwarder's 12:00. Null or the empty string means this carrier declares none; any other shape is a 400, because a cut-off the estimator cannot read is a delivery promise silently computed without one.
    public let cutoff_time: String?
    /// Transit time upper bound, in calendar days from the ship date.
    public let eta_days_max: Int?
    /// Transit time lower bound, in calendar days from the ship date — inherited by any method on this carrier that states no ETA of its own.
    public let eta_days_min: Int?
    /// Days needed to make a consignment ready for THIS carrier, added to the ship date before the transit days. Overrides the tenant's handling_days.
    public let handling_days: Int?
    /// Localized display names the seed would carry. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// The display name the seeded row would carry. An existing row keeps the merchant's own name — the seed never writes over one.
    public let name: String?
    /// Whether a fresh install starts with this carrier. False means this app knows how to describe it but only creates it when asked.
    public let seeded: Bool?
    /// Service-level code the seeded row carries — one of the tenant's own values.
    public let service_level: String?
    /// Tracking page URL with {tracking_code} where the number goes; {postal_code} and {country} are also substituted, URL-encoded. Null for a carrier with no public tracking page.
    public let tracking_url_template: String?

    init(
        code: String?,
        countries: [String]?,
        cutoff_time: String?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        handling_days: Int?,
        labels: [String: AnyCodable]?,
        name: String?,
        seeded: Bool?,
        service_level: String?,
        tracking_url_template: String?
    ) {
        self.code = code
        self.countries = countries
        self.cutoff_time = cutoff_time
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.handling_days = handling_days
        self.labels = labels
        self.name = name
        self.seeded = seeded
        self.service_level = service_level
        self.tracking_url_template = tracking_url_template
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String].self, forKey: .countries)
        self.cutoff_time = try container.decodeIfPresent(String.self, forKey: .cutoff_time)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.handling_days = try container.decodeIfPresent(Int.self, forKey: .handling_days)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.seeded = try container.decodeIfPresent(Bool.self, forKey: .seeded)
        self.service_level = try container.decodeIfPresent(String.self, forKey: .service_level)
        self.tracking_url_template = try container.decodeIfPresent(String.self, forKey: .tracking_url_template)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(cutoff_time, forKey: .cutoff_time)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(handling_days, forKey: .handling_days)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(seeded, forKey: .seeded)
        try container.encodeIfPresent(service_level, forKey: .service_level)
        try container.encodeIfPresent(tracking_url_template, forKey: .tracking_url_template)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "countries": countries as Any,
            "cutoff_time": cutoff_time as Any,
            "eta_days_max": eta_days_max as Any,
            "eta_days_min": eta_days_min as Any,
            "handling_days": handling_days as Any,
            "labels": labels as Any,
            "name": name as Any,
            "seeded": seeded as Any,
            "service_level": service_level as Any,
            "tracking_url_template": tracking_url_template as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingCarrierCatalogEntry {
        return ShippingCarrierCatalogEntry(
            code: map["code"] as? String,
            countries: map["countries"] as? [String],
            cutoff_time: map["cutoff_time"] as? String,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            handling_days: map["handling_days"] as? Int,
            labels: map["labels"] as? [String: AnyCodable],
            name: map["name"] as? String,
            seeded: map["seeded"] as? Bool,
            service_level: map["service_level"] as? String,
            tracking_url_template: map["tracking_url_template"] as? String
        )
    }
}
