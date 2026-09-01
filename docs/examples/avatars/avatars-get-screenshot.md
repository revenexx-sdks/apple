```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let avatars = Avatars(client)

let result = try await avatars.avatarsGetScreenshot(
    url: "https://example.com",
    headers: [:], // optional
    viewportWidth: 1, // optional
    viewportHeight: 1, // optional
    scale: 1, // optional
    theme: .light, // optional
    userAgent: "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15", // optional
    fullpage: true, // optional
    locale: "en-US", // optional
    timezone: .africaAbidjan, // optional
    latitude: 9.99, // optional
    longitude: 9.99, // optional
    accuracy: 9.99, // optional
    touch: true, // optional
    permissions: [.geolocation], // optional
    sleep: 1, // optional
    width: 1, // optional
    height: 1, // optional
    quality: 1, // optional
    output: .jpg // optional
)

```
