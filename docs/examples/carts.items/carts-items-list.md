```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsItems = CartsItems(client)

let error = try await cartsItems.cartsItemsList(
    cart_id: "",
    id: "", // optional
    type: .product, // optional
    product_id: "", // optional
    sku: "BOLT-M8-30", // optional
    name: "Hex bolt M8", // optional
    quantity: 100, // optional
    unit: "pcs", // optional
    unit_price: 0.12, // optional
    currency: "EUR", // optional
    tax_rate: 19, // optional
    line_total: 12, // optional
    position: 0, // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
