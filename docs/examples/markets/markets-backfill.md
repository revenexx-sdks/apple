```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsBackfill(
    id: "northwind",
    source: "northwind",
    currencies: true, // optional
    locales: true, // optional
    tax_classes: true // optional
)

```
