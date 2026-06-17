```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let storage = Storage(client)

let result = try await storage.assetStore(
    file: "",
    alt_text: "", // optional
    description: "", // optional
    display_name: "", // optional
    folder_id: "", // optional
    keep_archive: false, // optional
    tags: [], // optional
    unpack: false, // optional
    visibility: .public // optional
)

```
