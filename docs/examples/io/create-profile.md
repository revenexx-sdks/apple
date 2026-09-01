```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let io = Io(client)

let validationFailedResponse = try await io.createProfile(
    app: "",
    direction: .import,
    entity: "",
    format: "",
    name: "",
    vendor: "",
    apply_mode: .upsert, // optional
    mapping: [:], // optional
    markets: [], // optional
    options: [:] // optional
)

```
