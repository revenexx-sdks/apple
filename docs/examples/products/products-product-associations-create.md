```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let productAssociations = try await products.productsProductAssociationsCreate(
    association_type_id: "",
    product_id: "",
    target_product_id: "",
    position: 0, // optional
    quantity: 0 // optional
)

```
