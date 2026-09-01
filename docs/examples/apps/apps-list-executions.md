```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let executionList = try await apps.appsListExecutions(
    functionId: "",
    queries: [], // optional
    total: true // optional
)

```
