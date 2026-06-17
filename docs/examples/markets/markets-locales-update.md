```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let marketLocale = try await markets.marketsLocalesUpdate(
    market_id: "",
    id: "",
    code: "", // optional
    country: "", // optional
    is_default: false, // optional
    language: "", // optional
    position: 0 // optional
)

```
