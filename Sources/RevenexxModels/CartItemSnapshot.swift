import Foundation
import JSONCodable

/// The product as the buyer was shown it when this line was added — the cart's own copy, so it stays honest when the catalogue moves underneath it. Free-form apart from the price: conversion reads `unit_price` (or `price` as a fallback) and nothing else. A snapshot without a readable price leaves the line alone in both price modes, which is deliberate — a missing snapshot must never be read as "free".
open class CartItemSnapshot<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case price = "price"
        case unit_price = "unit_price"
        case data
    }

    /// The older spelling of the same thing, read only when `unit_price` is absent.
    public let price: Double?
    /// The net unit price the buyer was shown. This is what carts.order books the line on under price_snapshot_mode = snapshot, and what it rewrites under = live.
    public let unit_price: Double?
    /// Additional properties
    public let data: T

    init(
        price: Double?,
        unit_price: Double?,
        data: T
    ) {
        self.price = price
        self.unit_price = unit_price
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.unit_price = try container.decodeIfPresent(Double.self, forKey: .unit_price)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(unit_price, forKey: .unit_price)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "price": price as Any,
            "unit_price": unit_price as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> CartItemSnapshot {
        return CartItemSnapshot(
            price: map["price"] as? Double,
            unit_price: map["unit_price"] as? Double,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
