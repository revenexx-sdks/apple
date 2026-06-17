```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let attributeGroups = try await products.productsAttributeGroupsCreate(
    code: "",
    labels: [:], // optional
    position: 0 // optional
)

```
