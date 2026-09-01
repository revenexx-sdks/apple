```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsItems = CartsItems(client)

let error = try await cartsItems.cartsItemsCreate(
    cart_id: "",
    configuration: [
        "colour": "RAL 7016",
        "finish": "brushed",
        "length_mm": 2400,
        "mounting": "wall"
    ], // optional
    currency: "EUR", // optional
    metadata: [
        "campaign": "spring-catalogue",
        "locale": "de-DE",
        "source": "storefront"
    ], // optional
    name: "Hex bolt M8", // optional
    position: 1, // optional
    product_id: "", // optional
    quantity: 9.99, // optional
    sku: "BOLT-M8-30", // optional
    snapshot: [:], // optional
    tax_rate: 19, // optional
    type: .product, // optional
    unit: "pcs", // optional
    unit_price: 9.99 // optional
)

```
