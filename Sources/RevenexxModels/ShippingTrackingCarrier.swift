import Foundation
import JSONCodable
import RevenexxEnums

/// The carrier row that owns the URL format, identified so the caller can show who is carrying the parcel without a second read. Resolved whatever its status — a retired carrier still answers here.
open class ShippingTrackingCarrier: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case id = "id"
        case name = "name"
        case service_level = "service_level"
        case status = "status"
    }

    /// Stable carrier code, unique per tenant (e.g. dhl, dpd, gls). A method whose `carrier` text equals this code resolves to this carrier — that is the migration path off the free-text field. Deliberately no slug pattern: the column asks only for a non-empty string, and a contract stricter than the implementation would refuse codes merchants already keep.
    public let code: String?
    /// Row id, assigned by the database on insert.
    public let id: String?
    /// Display name, for the line that reads "shipped with …".
    public let name: String?
    /// The class of service this row represents (default 'standard'), as a CODE into the tenant's own service levels (GET /shipping/service-levels). One row is one class: a carrier selling both a parcel and an express product is two rows. Deliberately not an enum here — the set is the merchant's, so a fixed list in this contract would make the gateway reject a level they created. A code the tenant does not keep is a 400 naming the codes they do.
    public let service_level: String?
    /// Whether this carrier may be quoted (default 'active'). Anything else excludes every method that ships with it from POST /shipping/rates, with a reason. Tracking links are NOT gated on it — a retired carrier's old shipments stay resolvable. Reported here so a UI can mark a link as belonging to a carrier nobody quotes any more.
    public let status: RevenexxEnums.ShippingTrackingCarrierStatus?

    init(
        code: String?,
        id: String?,
        name: String?,
        service_level: String?,
        status: RevenexxEnums.ShippingTrackingCarrierStatus?
    ) {
        self.code = code
        self.id = id
        self.name = name
        self.service_level = service_level
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.service_level = try container.decodeIfPresent(String.self, forKey: .service_level)
        if let statusString = try container.decodeIfPresent(String.self, forKey: .status) {
            self.status = RevenexxEnums.ShippingTrackingCarrierStatus(rawValue: statusString)
        } else {
            self.status = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(service_level, forKey: .service_level)
        try container.encodeIfPresent(status?.rawValue, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "id": id as Any,
            "name": name as Any,
            "service_level": service_level as Any,
            "status": status?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ShippingTrackingCarrier {
        return ShippingTrackingCarrier(
            code: map["code"] as? String,
            id: map["id"] as? String,
            name: map["name"] as? String,
            service_level: map["service_level"] as? String,
            status: map["status"] as? String != nil ? ShippingTrackingCarrierStatus(rawValue: map["status"] as! String) : nil
        )
    }
}
