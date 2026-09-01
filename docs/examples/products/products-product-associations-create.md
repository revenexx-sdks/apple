```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let error = try await products.productsProductAssociationsCreate(
    association_type_id: "",
    product_id: "",
    target_product_id: "",
    position: 1, // optional
    quantity: 4 // optional
)

```
