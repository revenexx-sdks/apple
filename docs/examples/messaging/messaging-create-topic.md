```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let topic = try await messaging.messagingCreateTopic(
    name: "",
    topicId: "",
    subscribe: [] // optional
)

```
