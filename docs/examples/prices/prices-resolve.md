```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let result = try await prices.pricesResolve(
    items: [],
    at: "", // optional
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "", // optional
    market_id: "", // optional
    organization_id: "" // optional
)

```
