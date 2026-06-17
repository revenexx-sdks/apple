```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let productAssociations = try await products.productsProductAssociationsUpdate(
    id: "",
    association_type_id: "", // optional
    position: 0, // optional
    product_id: "", // optional
    quantity: 0, // optional
    target_product_id: "" // optional
)

```
