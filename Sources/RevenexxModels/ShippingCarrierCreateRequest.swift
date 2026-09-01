import Foundation
import JSONCodable
import RevenexxEnums

/// A new carrier — the tracking-URL template, service level, transit time and pickup cut-off a method inherits.
open class ShippingCarrierCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case countries = "countries"
        case cutoff_time = "cutoff_time"
        case eta_days_max = "eta_days_max"
        case eta_days_min = "eta_days_min"
        case handling_days = "handling_days"
        case labels = "labels"
        case metadata = "metadata"
        case name = "name"
        case position = "position"
        case service_level = "service_level"
        case status = "status"
        case tracking_url_template = "tracking_url_template"
    }

    /// Stable carrier code, unique per tenant (e.g. dhl, dpd, gls). A method whose `carrier` text equals this code resolves to this carrier — that is the migration path off the free-text field. Deliberately no slug pattern: the column asks only for a non-empty string, and a contract stricter than the implementation would refuse codes merchants already keep.
    public let code: String
    /// The countries this carrier serves. ISO 3166-1 alpha-2 codes; null or an empty array means no restriction. Compared upper-cased, so a lower-case entry still matches. Declared as an array rather than the bare object a jsonb column derives to — this one is always a list. ANDed with the method's own restriction: a method may not be offered into a country its carrier does not reach.
    public let countries: [String]?
    /// This carrier's own daily pickup cut-off, HH:MM in 24-hour form, UTC. Overrides the tenant's cutoff_time for methods on this carrier — one shop-wide time cannot be both DHL's 16:00 and a forwarder's 12:00. Null or the empty string means this carrier declares none; any other shape is a 400, because a cut-off the estimator cannot read is a delivery promise silently computed without one.
    public let cutoff_time: String?
    /// Transit time upper bound, in calendar days from the ship date.
    public let eta_days_max: Int?
    /// Transit time lower bound, in calendar days from the ship date — inherited by any method on this carrier that states no ETA of its own.
    public let eta_days_min: Int?
    /// Days needed to make a consignment ready for THIS carrier, added to the ship date before the transit days. Overrides the tenant's handling_days.
    public let handling_days: Int?
    /// Localized display names. A flat map keyed by locale — the Cockpit falls back to `en`. Null means the row has no translations and every client shows the untranslated column instead.
    public let labels: [String: AnyCodable]?
    /// Free-form jsonb the platform never reads or validates — whatever the merchant or their integration needs to keep beside the row (a customer number with the carrier, an ERP key, a label-printer id). The shape varies BY INTEGRATION, not by anything this app knows, so no key is declared and none is reserved; the example is one plausible instance rather than a schema. A flat map of scalars is the convention, and nothing enforces it.
    public let metadata: [String: AnyCodable]?
    /// Display name, as an operator typed it.
    public let name: String
    /// Sort order among the carriers; ties fall back to whatever the database returns.
    public let position: Int?
    /// The class of service this row represents (default 'standard'), as a CODE into the tenant's own service levels (GET /shipping/service-levels). One row is one class: a carrier selling both a parcel and an express product is two rows. Deliberately not an enum here — the set is the merchant's, so a fixed list in this contract would make the gateway reject a level they created. A code the tenant does not keep is a 400 naming the codes they do.
    public let service_level: String?
    /// Whether this carrier may be quoted (default 'active'). Anything else excludes every method that ships with it from POST /shipping/rates, with a reason. Tracking links are NOT gated on it — a retired carrier's old shipments stay resolvable.
    public let status: RevenexxEnums.ShippingCarrierStatus?
    /// Tracking page URL with {tracking_code} where the number goes; {postal_code} and {country} are also substituted, URL-encoded. Null for a carrier with no public tracking page.
    public let tracking_url_template: String?

    init(
        code: String,
        countries: [String]?,
        cutoff_time: String?,
        eta_days_max: Int?,
        eta_days_min: Int?,
        handling_days: Int?,
        labels: [String: AnyCodable]?,
        metadata: [String: AnyCodable]?,
        name: String,
        position: Int?,
        service_level: String?,
        status: RevenexxEnums.ShippingCarrierStatus?,
        tracking_url_template: String?
    ) {
        self.code = code
        self.countries = countries
        self.cutoff_time = cutoff_time
        self.eta_days_max = eta_days_max
        self.eta_days_min = eta_days_min
        self.handling_days = handling_days
        self.labels = labels
        self.metadata = metadata
        self.name = name
        self.position = position
        self.service_level = service_level
        self.status = status
        self.tracking_url_template = tracking_url_template
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.countries = try container.decodeIfPresent([String].self, forKey: .countries)
        self.cutoff_time = try container.decodeIfPresent(String.self, forKey: .cutoff_time)
        self.eta_days_max = try container.decodeIfPresent(Int.self, forKey: .eta_days_max)
        self.eta_days_min = try container.decodeIfPresent(Int.self, forKey: .eta_days_min)
        self.handling_days = try container.decodeIfPresent(Int.self, forKey: .handling_days)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.metadata = try container.decodeIfPresent([String: AnyCodable].self, forKey: .metadata)
        self.name = try container.decode(String.self, forKey: .name)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.service_level = try container.decodeIfPresent(String.self, forKey: .service_level)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ShippingCarrierStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
        self.tracking_url_template = try container.decodeIfPresent(String.self, forKey: .tracking_url_template)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(countries, forKey: .countries)
        try container.encodeIfPresent(cutoff_time, forKey: .cutoff_time)
        try container.encodeIfPresent(eta_days_max, forKey: .eta_days_max)
        try container.encodeIfPresent(eta_days_min, forKey: .eta_days_min)
        try container.encodeIfPresent(handling_days, forKey: .handling_days)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(metadata, forKey: .metadata)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(service_level, forKey: .service_level)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
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
            "metadata": metadata as Any,
            "name": name as Any,
            "position": position as Any,
            "service_level": service_level as Any,
            "status": status?.rawValue as Any,
            "tracking_url_template": tracking_url_template as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingCarrierCreateRequest {
        return ShippingCarrierCreateRequest(
            code: map["code"] as! String,
            countries: map["countries"] as? [String],
            cutoff_time: map["cutoff_time"] as? String,
            eta_days_max: map["eta_days_max"] as? Int,
            eta_days_min: map["eta_days_min"] as? Int,
            handling_days: map["handling_days"] as? Int,
            labels: map["labels"] as? [String: AnyCodable],
            metadata: map["metadata"] as? [String: AnyCodable],
            name: map["name"] as! String,
            position: map["position"] as? Int,
            service_level: map["service_level"] as? String,
            status: map["status"] as? String != nil ? ShippingCarrierStatus(rawValue: map["status"] as! String) : nil,
            tracking_url_template: map["tracking_url_template"] as? String
        )
    }
}
