```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let error = try await pages.pagesPagesUpdate(
    id: "",
    bundle: "standard", // optional
    meta: [:], // optional
    slug: "about-us", // optional
    status: .draft, // optional
    title: "About us" // optional
)

```
