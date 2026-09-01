```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let io = Io(client)

let validationFailedResponse = try await io.runProfile(
    id: "",
    markets: [], // optional
    object_key: "" // optional
)

```
