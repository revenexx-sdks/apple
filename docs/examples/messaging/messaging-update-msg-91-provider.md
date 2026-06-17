```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let provider = try await messaging.messagingUpdateMsg91Provider(
    providerId: "",
    authKey: "", // optional
    enabled: false, // optional
    name: "", // optional
    senderId: "", // optional
    templateId: "" // optional
)

```
