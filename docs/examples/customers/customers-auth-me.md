```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let error = try await customers.customersAuthMe(
    user_id: "",
    session_id: "" // optional
)

```
