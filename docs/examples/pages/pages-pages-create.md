```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let page = try await pages.pagesPagesCreate(
    title: "",
    bundle: "", // optional
    hostOptions: [:], // optional
    meta: [:], // optional
    slug: "", // optional
    sourceLanguage: "" // optional
)

```
