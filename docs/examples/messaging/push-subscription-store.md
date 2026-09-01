```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.pushSubscriptionStore(
    endpoint: "https://example.com",
    keys: [:],
    subscriber_id: "",
    user_agent: "" // optional
)

```
