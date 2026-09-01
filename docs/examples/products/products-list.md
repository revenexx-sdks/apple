```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let result = try await products.productsList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    sku: "ACME-4711-BLK", // optional
    kind: .simple, // optional
    parent_id: "", // optional
    family_id: "", // optional
    family_variant_id: "", // optional
    enabled: true, // optional
    tax_class: "standard", // optional
    attribute_values: "{}", // optional
    label: "Akku-Bohrschrauber 18V", // optional
    quantified_associations: "{}", // optional
    completeness: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    deleted_at: "2026-01-01T12:00:00Z" // optional
)

```
