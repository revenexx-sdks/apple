```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let deployment = try await apps.appsCreateTemplateDeployment(
    functionId: "",
    owner: "",
    reference: "",
    repository: "",
    rootDirectory: "",
    type: .commit,
    activate: false // optional
)

```
