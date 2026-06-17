```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let result = try await apps.appsListMarketplace(
    search: "", // optional
    per_page: 0, // optional
    page: 0 // optional
)

```
