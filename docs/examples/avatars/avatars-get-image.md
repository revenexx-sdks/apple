```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let avatars = Avatars(client)

let result = try await avatars.avatarsGetImage(
    url: "https://www.revenexx.com/img/hero-revenexx-poster.webp",
    width: 1, // optional
    height: 1 // optional
)

```
