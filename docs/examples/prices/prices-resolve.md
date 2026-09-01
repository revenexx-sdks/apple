```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesResolve(
    items: [],
    at: "2026-03-15T09:00:00Z", // optional
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "EUR", // optional
    market_id: "", // optional
    organization_id: "" // optional
)

```
