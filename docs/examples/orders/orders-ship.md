```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let result = try await orders.ordersShip(
    id: "",
    carrier: "", // optional
    metadata: [:], // optional
    number: "", // optional
    positions: [], // optional
    shipped_at: "", // optional
    tracking_code: "", // optional
    tracking_url: "" // optional
)

```
