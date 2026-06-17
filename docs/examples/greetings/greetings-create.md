```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let greetings = Greetings(client)

let result = try await greetings.greetingsCreate(
    name: "",
    locale: "" // optional
)

```
