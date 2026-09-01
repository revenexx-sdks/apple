```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let orderCustomerRollupResponse = try await orders.ordersReportsCustomerRollup(
    as_of: "2026-01-01T12:00:00Z", // optional
    cursor: "", // optional
    organization_ids: [], // optional
    statuses: [.pending] // optional
)

```
