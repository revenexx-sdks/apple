```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.statsIndex(
    days: 1, // optional
    from: "2026-01-01", // optional
    to: "2026-01-01" // optional
)

```
