```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let error = try await pages.pagesPagesRevisions(
    id: "",
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    label: "Autumn campaign", // optional
    created_by: "", // optional
    created_by_name: "", // optional
    created_at: "" // optional
)

```
