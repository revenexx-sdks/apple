```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let carts = Carts(client)

let cartItem = try await carts.cartsItemsUpdate(
    cart_id: "",
    id: "",
    configuration: [:], // optional
    currency: "", // optional
    metadata: [:], // optional
    name: "", // optional
    position: 0, // optional
    product_id: "", // optional
    quantity: 0, // optional
    sku: "", // optional
    snapshot: [:], // optional
    tax_rate: 0, // optional
    type: .product, // optional
    unit: "", // optional
    unit_price: 0 // optional
)

```
