```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let marketTaxClass = try await markets.marketsTaxClassesUpdate(
    market_id: "",
    id: "",
    code: "", // optional
    is_default: false, // optional
    labels: [:], // optional
    name: "", // optional
    position: 0, // optional
    rate: 0 // optional
)

```
