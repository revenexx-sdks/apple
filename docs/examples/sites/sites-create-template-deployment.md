```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let deployment = try await sites.sitesCreateTemplateDeployment(
    siteId: "",
    owner: "",
    reference: "",
    repository: "",
    rootDirectory: "",
    type: .branch,
    activate: true // optional
)

```
