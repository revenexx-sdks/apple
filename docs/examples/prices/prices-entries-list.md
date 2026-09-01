```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesEntriesList(
    list_id: "",
    id: "", // optional
    product_id: "", // optional
    sku: "BOLT-M8-30", // optional
    price_type: .standard, // optional
    quantity_min: 9.99, // optional
    unit_price: 9.99, // optional
    unit: "pcs", // optional
    valid_from: "2026-01-01T12:00:00Z", // optional
    valid_until: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
