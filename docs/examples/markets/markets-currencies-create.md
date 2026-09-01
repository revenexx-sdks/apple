```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsCurrenciesCreate(
    market_id: "",
    code: "EUR",
    is_default: true, // optional
    position: 0 // optional
)

```
