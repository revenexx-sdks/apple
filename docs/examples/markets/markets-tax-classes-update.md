```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsTaxClassesUpdate(
    market_id: "",
    id: "",
    code: "standard", // optional
    is_default: true, // optional
    labels: [
        "de-DE": "Regelsatz",
        "en-GB": "Standard rate"
    ], // optional
    name: "Standard rate", // optional
    position: 0, // optional
    rate: 20 // optional
)

```
