```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let storage = Storage(client)

let result = try await storage.assetStore(
    file: InputFile.fromPath("file.png"),
    alt_text: "", // optional
    description: "", // optional
    display_name: "", // optional
    folder_id: "", // optional
    keep_archive: true, // optional
    tags: [], // optional
    unpack: true, // optional
    visibility: .public // optional
)

```
