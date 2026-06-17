```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let storage = Storage(client)

let result = try await storage.syncRuleHistory(
    rule_id: "", // optional
    from: "", // optional
    to: "" // optional
)

```
