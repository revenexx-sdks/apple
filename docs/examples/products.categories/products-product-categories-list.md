```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsCategories = ProductsCategories(client)

let result = try await productsCategories.productsProductCategoriesList(
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc", // optional
    id: "", // optional
    product_id: "", // optional
    category_id: "", // optional
    position: 1, // optional
    source: .manual, // optional
    created_at: "2026-01-01T12:00:00Z" // optional
)

```
