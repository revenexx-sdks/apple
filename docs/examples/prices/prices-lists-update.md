```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesListsUpdate(
    id: "",
    channel_id: "", // optional
    code: "dealer-de", // optional
    contact_id: "", // optional
    currency: "EUR", // optional
    description: "Contract prices for authorised dealers.", // optional
    is_default: true, // optional
    labels: [
        "de": "Händlerpreise",
        "en": "Dealer prices"
    ], // optional
    metadata: [
        "erp_price_group": "A1",
        "source_system": "erp"
    ], // optional
    name: "Dealer prices", // optional
    organization_id: "", // optional
    priority: 1, // optional
    requires_auth: true, // optional
    status: .active, // optional
    tax_basis: .net, // optional
    tax_included: true, // optional
    valid_from: "2026-01-01T00:00:00Z", // optional
    valid_until: "2026-12-31T23:59:59Z" // optional
)

```
