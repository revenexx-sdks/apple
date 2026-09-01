```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsIo = CartsIo(client)

let error = try await cartsIo.cartsIoProfilesUpdate(
    id: "",
    apply_mode: .insert, // optional
    direction: .import, // optional
    entity: .carts, // optional
    format: .json, // optional
    is_template: true, // optional
    mapping: [:], // optional
    name: "cart-export-csv", // optional
    options: [:] // optional
)

```
