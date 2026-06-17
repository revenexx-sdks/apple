```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let sites = Sites(client)

let deployment = try await sites.sitesCreateDeployment(
    siteId: "",
    activate: false,
    code: "",
    buildCommand: "", // optional
    installCommand: "", // optional
    outputDirectory: "" // optional
)

```
