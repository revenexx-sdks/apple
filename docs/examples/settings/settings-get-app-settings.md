```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let settings = Settings(client)

let result = try await settings.settingsGetAppSettings(
    app: "",
    market: "" // optional
)

```
