```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersShip(
    id: "",
    carrier: "DHL", // optional
    metadata: [
        "warehouse": "HAM-1"
    ], // optional
    number: "DEL-000123", // optional
    positions: [], // optional
    shipped_at: "2026-01-01T12:00:00Z", // optional
    tracking_code: "00340434161234567890", // optional
    tracking_url: "https://example.com/track/00340434161234567890" // optional
)

```
