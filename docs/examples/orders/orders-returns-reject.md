```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersReturnsReject(
    id: "",
    rid: "",
    reason: "Returned outside the agreed window", // optional
    resolution: .wearAndTear // optional
)

```
