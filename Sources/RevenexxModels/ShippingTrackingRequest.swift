import Foundation
import JSONCodable

/// One parcel, resolved into a tracking link by the carrier that owns the URL format.
open class ShippingTrackingRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case carrier = "carrier"
        case country = "country"
        case postal_code = "postal_code"
        case tracking_code = "tracking_code"
    }

    /// Carrier code (what an order shipment already stores) or the carrier row id — a value matching the uuid form is read as the id, anything else as a code, case-insensitively. Must name a carrier THIS tenant keeps; one that does not is a 404.
    public let carrier: String
    /// Destination ISO 3166-1 alpha-2 code — only needed by a template that names {country}. Upper-cased before substitution.
    public let country: String?
    /// Destination postcode — only needed by a template that names {postal_code}.
    public let postal_code: String?
    /// The carrier's tracking number. Required by every template that names {tracking_code}, which is all of them in the shipped catalog. URL-encoded before substitution, so a code with a space or a slash cannot reshape the link.
    public let tracking_code: String?

    init(
        carrier: String,
        country: String?,
        postal_code: String?,
        tracking_code: String?
    ) {
        self.carrier = carrier
        self.country = country
        self.postal_code = postal_code
        self.tracking_code = tracking_code
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.carrier = try container.decode(String.self, forKey: .carrier)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.postal_code = try container.decodeIfPresent(String.self, forKey: .postal_code)
        self.tracking_code = try container.decodeIfPresent(String.self, forKey: .tracking_code)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(carrier, forKey: .carrier)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(postal_code, forKey: .postal_code)
        try container.encodeIfPresent(tracking_code, forKey: .tracking_code)
    }

    public func toMap() -> [String: Any] {
        return [
            "carrier": carrier as Any,
            "country": country as Any,
            "postal_code": postal_code as Any,
            "tracking_code": tracking_code as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingTrackingRequest {
        return ShippingTrackingRequest(
            carrier: map["carrier"] as! String,
            country: map["country"] as? String,
            postal_code: map["postal_code"] as? String,
            tracking_code: map["tracking_code"] as? String
        )
    }
}
