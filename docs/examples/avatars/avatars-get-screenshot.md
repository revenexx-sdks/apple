```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let avatars = Avatars(client)

let result = try await avatars.avatarsGetScreenshot(
    url: "",
    headers: [:], // optional
    viewportWidth: 0, // optional
    viewportHeight: 0, // optional
    scale: 0, // optional
    theme: .light, // optional
    userAgent: "", // optional
    fullpage: false, // optional
    locale: "", // optional
    timezone: .africaAbidjan, // optional
    latitude: 0, // optional
    longitude: 0, // optional
    accuracy: 0, // optional
    touch: false, // optional
    permissions: [.geolocation], // optional
    sleep: 0, // optional
    width: 0, // optional
    height: 0, // optional
    quality: 0, // optional
    output: .jpg // optional
)

```
