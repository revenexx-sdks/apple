```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesEntriesCreate(
    list_id: "",
    metadata: [
        "imported_batch": "2026-02-14",
        "source_system": "erp"
    ], // optional
    price_type: .standard, // optional
    product_id: "", // optional
    quantity_min: 9.99, // optional
    sku: "BOLT-M8-30", // optional
    unit: "pcs", // optional
    unit_price: 9.99, // optional
    valid_from: "2026-03-01T00:00:00Z", // optional
    valid_until: "2026-03-31T23:59:59Z" // optional
)

```
