```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let error = try await pages.pagesTemplatesUpdate(
    id: "",
    description: "Full-width hero followed by a two-column teaser row.", // optional
    field_name: "content", // optional
    is_default: true, // optional
    label: "Hero with two teasers", // optional
    page_bundle: "standard", // optional
    tree: [] // optional
)

```
