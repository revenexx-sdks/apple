```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.bindingUpdate(
    id: "",
    channel: "", // optional
    enabled: true, // optional
    event_topic: "", // optional
    fallback_order: 1, // optional
    locale: "", // optional
    recipient: "", // optional
    template_key: "" // optional
)

```
