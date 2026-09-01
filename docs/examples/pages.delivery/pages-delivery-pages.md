```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesDelivery = PagesDelivery(client)

let result = try await pagesDelivery.pagesDeliveryPages(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    bundle: "standard" // optional
)

```
