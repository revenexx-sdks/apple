```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.suppressionStore(
    address: "",
    channel: "",
    reason: .hardBounce,
    expires_at: "2026-01-01T12:00:00Z", // optional
    note: "", // optional
    scope: .all // optional
)

```
