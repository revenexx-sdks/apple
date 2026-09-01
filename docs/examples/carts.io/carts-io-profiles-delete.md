```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsIo = CartsIo(client)

let error = try await cartsIo.cartsIoProfilesDelete(
    id: ""
)

```
