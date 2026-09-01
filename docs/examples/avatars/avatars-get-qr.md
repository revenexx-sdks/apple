```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let avatars = Avatars(client)

let result = try await avatars.avatarsGetQR(
    text: "",
    size: 1, // optional
    margin: 1, // optional
    download: true // optional
)

```
