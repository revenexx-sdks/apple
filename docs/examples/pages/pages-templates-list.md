```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let result = try await pages.pagesTemplatesList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    label: "Hero with two teasers", // optional
    description: "Full-width hero followed by a two-column teaser row.", // optional
    page_bundle: "standard", // optional
    field_name: "content", // optional
    is_default: true, // optional
    created_by: "", // optional
    created_at: "", // optional
    updated_at: "" // optional
)

```
