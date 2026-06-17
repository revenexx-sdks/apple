```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let market = try await markets.marketsCreate(
    code: "",
    name: "",
    currency: "", // optional
    is_default: false, // optional
    labels: [:], // optional
    position: 0, // optional
    status: .active // optional
)

```
