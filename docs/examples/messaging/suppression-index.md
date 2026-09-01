```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.suppressionIndex(
    channel: "", // optional
    scope: .all, // optional
    reason: .hardBounce, // optional
    address: "", // optional
    limit: 1 // optional
)

```
