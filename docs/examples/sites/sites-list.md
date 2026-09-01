```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let siteList = try await sites.sitesList(
    queries: [], // optional
    search: "", // optional
    total: true // optional
)

```
