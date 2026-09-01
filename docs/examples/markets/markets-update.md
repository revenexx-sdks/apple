```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsUpdate(
    id: "",
    code: "northwind", // optional
    currency: "EUR", // optional
    is_default: false, // optional
    labels: [
        "de-DE": "Nordwind",
        "en-GB": "Northwind"
    ], // optional
    name: "Northwind", // optional
    position: 0, // optional
    status: .active // optional
)

```
