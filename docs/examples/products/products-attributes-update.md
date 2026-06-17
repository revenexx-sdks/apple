```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let attributes = try await products.productsAttributesUpdate(
    id: "",
    code: "", // optional
    config: [:], // optional
    entity_ref: "", // optional
    entity_type: "", // optional
    group_id: "", // optional
    is_filterable: false, // optional
    is_unique: false, // optional
    labels: [:], // optional
    localizable: false, // optional
    position: 0, // optional
    scopable: false, // optional
    type: "", // optional
    usable_in_grid: false, // optional
    validation: [:] // optional
)

```
