```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let storage = Storage(client)

let result = try await storage.syncRuleHistory(
    rule_id: "", // optional
    from: "2026-01-01T12:00:00Z", // optional
    to: "2026-01-01T12:00:00Z" // optional
)

```
