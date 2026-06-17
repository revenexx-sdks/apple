```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let template = try await pages.pagesTemplatesUpdate(
    id: "",
    description: "", // optional
    field_name: "", // optional
    is_default: false, // optional
    label: "", // optional
    page_bundle: "", // optional
    tree: [] // optional
)

```
