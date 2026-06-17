```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let mutationResponse = try await pages.pagesEditorMutationStatus(
    page_id: "",
    enabled: false,
    index: 0,
    langcode: "" // optional
)

```
