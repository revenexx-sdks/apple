```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let message = try await messaging.messagingUpdatePush(
    messageId: "",
    action: "", // optional
    badge: 0, // optional
    body: "", // optional
    color: "", // optional
    contentAvailable: false, // optional
    critical: false, // optional
    data: [:], // optional
    draft: false, // optional
    icon: "", // optional
    image: "", // optional
    priority: .normal, // optional
    scheduledAt: "", // optional
    sound: "", // optional
    tag: "", // optional
    targets: [], // optional
    title: "", // optional
    topics: [], // optional
    users: [] // optional
)

```
