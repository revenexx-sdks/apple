```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let marketCurrency = try await markets.marketsCurrenciesCreate(
    market_id: "",
    code: "",
    is_default: false, // optional
    position: 0 // optional
)

```
