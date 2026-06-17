```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let message = try await messaging.messagingUpdateEmail(
    messageId: "",
    attachments: [], // optional
    bcc: [], // optional
    cc: [], // optional
    content: "", // optional
    draft: false, // optional
    html: false, // optional
    scheduledAt: "", // optional
    subject: "", // optional
    targets: [], // optional
    topics: [], // optional
    users: [] // optional
)

```
