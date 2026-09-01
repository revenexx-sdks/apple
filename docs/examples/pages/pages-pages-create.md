```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let error = try await pages.pagesPagesCreate(
    title: "About us",
    bundle: "standard", // optional
    hostOptions: [:], // optional
    meta: [:], // optional
    slug: "about-us", // optional
    sourceLanguage: "de" // optional
)

```
