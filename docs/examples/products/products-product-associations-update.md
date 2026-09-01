```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let error = try await products.productsProductAssociationsUpdate(
    id: "",
    association_type_id: "", // optional
    position: 1, // optional
    product_id: "", // optional
    quantity: 4, // optional
    target_product_id: "" // optional
)

```
