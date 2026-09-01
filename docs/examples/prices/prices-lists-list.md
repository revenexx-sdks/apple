```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesListsList(
    id: "", // optional
    code: "standard", // optional
    name: "Standard prices", // optional
    description: "The list every buyer falls back to.", // optional
    currency: "EUR", // optional
    status: .active, // optional
    priority: 1, // optional
    is_default: true, // optional
    tax_basis: .net, // optional
    tax_included: true, // optional
    requires_auth: true, // optional
    contact_id: "", // optional
    organization_id: "", // optional
    channel_id: "", // optional
    valid_from: "2026-01-01T12:00:00Z", // optional
    valid_until: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
