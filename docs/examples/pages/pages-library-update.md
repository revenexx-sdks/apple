```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let libraryItem = try await pages.pagesLibraryUpdate(
    id: "",
    bundle: "", // optional
    label: "", // optional
    tree: [:] // optional
)

```
