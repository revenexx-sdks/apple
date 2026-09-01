```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsCreate(
    code: "northwind",
    name: "Northwind",
    currency: "EUR", // optional
    is_default: false, // optional
    labels: [
        "de-DE": "Nordwind",
        "en-GB": "Northwind"
    ], // optional
    position: 0, // optional
    status: .active // optional
)

```
