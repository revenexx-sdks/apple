```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let page = try await pages.pagesPagesUpdate(
    id: "",
    bundle: "", // optional
    meta: [:], // optional
    slug: "", // optional
    status: .draft, // optional
    title: "" // optional
)

```
