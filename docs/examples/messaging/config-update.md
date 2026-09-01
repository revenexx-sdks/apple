```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.configUpdate(
    default_locale: "", // optional
    defaults: [], // optional
    product: "", // optional
    quiet_hours: [], // optional
    support_email: "jane@example.com" // optional
)

```
