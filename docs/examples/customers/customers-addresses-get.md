```swift
import RevenexxAPIRevenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let address = try await customers.customersAddressesGet(
    id: ""
)

```
