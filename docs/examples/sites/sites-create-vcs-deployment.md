```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let deployment = try await sites.sitesCreateVcsDeployment(
    siteId: "",
    reference: "",
    type: .branch,
    activate: false // optional
)

```
