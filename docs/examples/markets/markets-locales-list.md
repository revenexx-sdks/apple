```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsLocalesList(
    market_id: "",
    id: "", // optional
    code: "de-DE", // optional
    language: "de", // optional
    country: "DE", // optional
    is_default: true, // optional
    position: 0, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "position.asc" // optional
)

```
