```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let apps = Apps(client)

let execution = try await apps.appsCreateExecution(
    functionId: "",
    async: false, // optional
    body: "", // optional
    headers: [:], // optional
    method: .gET, // optional
    path: "", // optional
    scheduledAt: "" // optional
)

```
