```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let error = try await orderlists.orderlistsItemsList(
    list_id: "",
    id: "", // optional
    product_id: "", // optional
    sku: "ACME-4711-BLK", // optional
    name: "Copy paper A4, 80 g/m², white", // optional
    image: "https://cdn.example.com/catalog/acme-4711-blk.jpg", // optional
    quantity: 12, // optional
    unit: "piece", // optional
    price: 3.49, // optional
    tax_rate: 19, // optional
    cost_center_id: "CC-100", // optional
    position_texts: "{}", // optional
    custom_sku: "CUST-4711", // optional
    category_slug: "office-supplies", // optional
    subcategory_slug: "paper", // optional
    position: 0, // optional
    metadata: "{}", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
