```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let io = Io(client)

let validationFailedResponse = try await io.createImport(
    app: "",
    entity: "",
    object_key: "",
    vendor: "",
    format: .csv, // optional
    keys: [], // optional
    max_rejects: 1, // optional
    mode: .upsert, // optional
    profile_id: "", // optional
    target: .live // optional
)

```
