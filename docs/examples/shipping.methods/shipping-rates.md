```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingMethods = ShippingMethods(client)

let error = try await shippingMethods.shippingRates(
    at: "2026-01-01T12:00:00Z", // optional
    attributes: [
        "volume_litres": 48
    ], // optional
    country: "DE", // optional
    currency: "EUR", // optional
    market_id: "3f2b6d10-7c41-4c0a-9a35-2f5b8e0d9c11", // optional
    order_value: 129.9, // optional
    order_value_gross: 129.9, // optional
    order_value_net: 109.16, // optional
    quantity: 3, // optional
    weight: 12.5, // optional
    weight_unit: "kg" // optional
)

```
