```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let marketLocale = try await markets.marketsLocalesCreate(
    market_id: "",
    code: "",
    country: "",
    language: "",
    is_default: false, // optional
    position: 0 // optional
)

```
