```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let template = try await pages.pagesEditorTemplatesCreate(
    page_id: "",
    label: "",
    uuids: [],
    description: "", // optional
    fieldName: "", // optional
    isDefault: false, // optional
    pageBundle: "" // optional
)

```
