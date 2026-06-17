```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let mutationResponse = try await pages.pagesEditorPublish(
    page_id: "",
    force: false, // optional
    label: "" // optional
)

```
