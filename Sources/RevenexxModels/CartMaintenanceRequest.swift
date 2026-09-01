import Foundation
import JSONCodable

/// 
open class CartMaintenanceRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case dry_run = "dry_run"
    }

    /// Report what the sweep WOULD do and write nothing. Worth doing before a first retention run: cart_ttl_days deletes carts and their lines.
    public let dry_run: Bool?

    init(
        dry_run: Bool?
    ) {
        self.dry_run = dry_run
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.dry_run = try container.decodeIfPresent(Bool.self, forKey: .dry_run)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(dry_run, forKey: .dry_run)
    }

    public func toMap() -> [String: Any] {
        return [
            "dry_run": dry_run as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartMaintenanceRequest {
        return CartMaintenanceRequest(
            dry_run: map["dry_run"] as? Bool
        )
    }
}
