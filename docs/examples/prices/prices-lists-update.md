```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let priceList = try await prices.pricesListsUpdate(
    id: "",
    channel_id: "", // optional
    code: "", // optional
    contact_id: "", // optional
    currency: "", // optional
    description: "", // optional
    is_default: false, // optional
    labels: [:], // optional
    market_id: "", // optional
    metadata: [:], // optional
    name: "", // optional
    organization_id: "", // optional
    priority: 0, // optional
    status: .active, // optional
    tax_included: false, // optional
    valid_from: "", // optional
    valid_until: "" // optional
)

```
