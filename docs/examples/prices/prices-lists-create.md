```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let priceList = try await prices.pricesListsCreate(
    code: "",
    name: "",
    channel_id: "", // optional
    contact_id: "", // optional
    currency: "", // optional
    description: "", // optional
    is_default: false, // optional
    labels: [:], // optional
    market_id: "", // optional
    metadata: [:], // optional
    organization_id: "", // optional
    priority: 0, // optional
    status: .active, // optional
    tax_included: false, // optional
    valid_from: "", // optional
    valid_until: "" // optional
)

```
