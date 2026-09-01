```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsCategories = ProductsCategories(client)

let result = try await productsCategories.productsCategoriesList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    code: "cordless_drills", // optional
    parent_id: "", // optional
    path: "tools/power_tools/cordless_drills", // optional
    position: 1, // optional
    labels: "{}", // optional
    values: "{}", // optional
    rules: "{}", // optional
    rule_match: .all, // optional
    rules_computed_at: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z" // optional
)

```
