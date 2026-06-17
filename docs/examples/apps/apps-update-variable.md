```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let variable = try await apps.appsUpdateVariable(
    functionId: "",
    variableId: "",
    key: "",
    secret: false, // optional
    value: "" // optional
)

```
