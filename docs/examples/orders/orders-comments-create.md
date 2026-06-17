```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let orderComment = try await orders.ordersCommentsCreate(
    id: "",
    body: "",
    author: "", // optional
    visibility: .internal // optional
)

```
