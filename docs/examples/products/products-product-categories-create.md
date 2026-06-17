```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let productCategories = try await products.productsProductCategoriesCreate(
    category_id: "",
    product_id: "",
    position: 0 // optional
)

```
