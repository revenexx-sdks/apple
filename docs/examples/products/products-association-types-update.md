```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let associationTypes = try await products.productsAssociationTypesUpdate(
    id: "",
    code: "", // optional
    is_quantified: false, // optional
    is_two_way: false, // optional
    labels: [:] // optional
)

```
