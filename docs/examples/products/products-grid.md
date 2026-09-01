```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let error = try await products.productsGrid(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    q: "cordless drill", // optional
    kind: .simple, // optional
    enabled: true, // optional
    family_id: "" // optional
)

```
