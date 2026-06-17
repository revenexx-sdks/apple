```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let variable = try await sites.sitesCreateVariable(
    siteId: "",
    key: "",
    value: "",
    secret: false // optional
)

```
