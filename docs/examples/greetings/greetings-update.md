```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let greetings = Greetings(client)

let greeting = try await greetings.greetingsUpdate(
    id: "",
    locale: "", // optional
    message: "", // optional
    metadata: [:], // optional
    name: "" // optional
)

```
