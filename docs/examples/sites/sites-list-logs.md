```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let executionList = try await sites.sitesListLogs(
    siteId: "",
    queries: [], // optional
    total: false // optional
)

```
