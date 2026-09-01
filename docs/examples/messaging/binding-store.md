```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.bindingStore(
    channel: "",
    event_topic: "",
    recipient: "",
    template_key: "",
    enabled: true, // optional
    fallback_order: 1, // optional
    locale: "" // optional
)

```
