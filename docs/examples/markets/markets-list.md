```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsList(
    id: "", // optional
    code: "northwind", // optional
    name: "Northwind", // optional
    labels: "{"de-DE":"Nordwind","en-GB":"Northwind"}", // optional
    currency: "EUR", // optional
    status: .active, // optional
    is_default: false, // optional
    position: 0, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "position.asc" // optional
)

```
