```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesDelivery = PagesDelivery(client)

let error = try await pagesDelivery.pagesDeliveryPage(
    slug: "about-us", // optional
    id: "", // optional
    langcode: "de" // optional
)

```
