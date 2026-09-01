```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pages = Pages(client)

let result = try await pages.pagesPagesList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    bundle: "standard", // optional
    status: .draft, // optional
    q: "contact" // optional
)

```
