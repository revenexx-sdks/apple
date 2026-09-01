import Foundation
import JSONCodable

/// What this app ASKED inventories for, and what it answered. This app holds no stock: inventories picks the location, applies the backorder policy and owns the hold's expiry.
open class CartConversionReservation: Codable {

    enum CodingKeys: String, CodingKey {
        case backordered = "backordered"
        case expires_at = "expires_at"
        case ok = "ok"
        case order_ref = "order_ref"
        case reason = "reason"
        case requested = "requested"
        case reservations = "reservations"
        case status = "status"
    }

    /// Lines inventories accepted without stock behind them, under the tenant's backorder policy — its policy, not this app's.
    public let backordered: Int?
    /// inventories' hold deadline — its TTL, not this app's.
    public let expires_at: String?
    /// A hold exists. False with `requested: true` means inventories was asked and refused — `reason` says why, and only convert_reserves_stock = require turns that into a 409.
    public let ok: Bool?
    /// The reference the reservation was booked under: the `order_ref` of the request, or the cart id when the call carried none. This is the string to hand inventories when releasing the hold.
    public let order_ref: String?
    /// Why no hold exists — stated, never implied. Present whenever `ok` is false, and also on the never case.
    public let reason: String?
    /// False when convert_reserves_stock is 'never' — no call was made at all, which is reported rather than dressed up as a silent success.
    public let requested: Bool?
    /// Lines inventories confirmed a hold for.
    public let reservations: Int?
    /// The HTTP status inventories answered with, present only when it refused. 404 is its own case: the tenant has no inventories app at all, which is a different problem from not enough stock.
    public let status: Int?

    init(
        backordered: Int?,
        expires_at: String?,
        ok: Bool?,
        order_ref: String?,
        reason: String?,
        requested: Bool?,
        reservations: Int?,
        status: Int?
    ) {
        self.backordered = backordered
        self.expires_at = expires_at
        self.ok = ok
        self.order_ref = order_ref
        self.reason = reason
        self.requested = requested
        self.reservations = reservations
        self.status = status
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.backordered = try container.decodeIfPresent(Int.self, forKey: .backordered)
        self.expires_at = try container.decodeIfPresent(String.self, forKey: .expires_at)
        self.ok = try container.decodeIfPresent(Bool.self, forKey: .ok)
        self.order_ref = try container.decodeIfPresent(String.self, forKey: .order_ref)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.requested = try container.decodeIfPresent(Bool.self, forKey: .requested)
        self.reservations = try container.decodeIfPresent(Int.self, forKey: .reservations)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(backordered, forKey: .backordered)
        try container.encodeIfPresent(expires_at, forKey: .expires_at)
        try container.encodeIfPresent(ok, forKey: .ok)
        try container.encodeIfPresent(order_ref, forKey: .order_ref)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(requested, forKey: .requested)
        try container.encodeIfPresent(reservations, forKey: .reservations)
        try container.encodeIfPresent(status, forKey: .status)
    }

    public func toMap() -> [String: Any] {
        return [
            "backordered": backordered as Any,
            "expires_at": expires_at as Any,
            "ok": ok as Any,
            "order_ref": order_ref as Any,
            "reason": reason as Any,
            "requested": requested as Any,
            "reservations": reservations as Any,
            "status": status as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartConversionReservation {
        return CartConversionReservation(
            backordered: map["backordered"] as? Int,
            expires_at: map["expires_at"] as? String,
            ok: map["ok"] as? Bool,
            order_ref: map["order_ref"] as? String,
            reason: map["reason"] as? String,
            requested: map["requested"] as? Bool,
            reservations: map["reservations"] as? Int,
            status: map["status"] as? Int
        )
    }
}
