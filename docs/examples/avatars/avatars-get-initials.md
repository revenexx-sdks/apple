```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let avatars = Avatars(client)

let result = try await avatars.avatarsGetInitials(
    name: "Ada Lovelace", // optional
    width: 1, // optional
    height: 1, // optional
    background: "1a73e8" // optional
)

```
