```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let products = try await products.productsUpdate(
    id: "",
    attribute_values: [:], // optional
    completeness: [:], // optional
    deleted_at: "", // optional
    enabled: false, // optional
    family_id: "", // optional
    family_variant_id: "", // optional
    kind: "", // optional
    parent_id: "", // optional
    quantified_associations: [:], // optional
    sku: "", // optional
    tax_class: "" // optional
)

```
