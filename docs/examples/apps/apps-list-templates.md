```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let templateFunctionList = try await apps.appsListTemplates(
    runtimes: [.node180], // optional
    useCases: [.starter], // optional
    limit: 0, // optional
    offset: 0, // optional
    total: false // optional
)

```
