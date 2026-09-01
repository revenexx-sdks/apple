```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let cartsIo = CartsIo(client)

let error = try await cartsIo.cartsImport(
    contact_id: "", // optional
    csv: "sku,name,quantity,unit_price
BOLT-M8-30,Hex bolt M8,100,0.12
NUT-M8,Hex nut M8,100,0.04
", // optional
    name: "Weekly order", // optional
    payload: [
        "cart": [
            "currency": "EUR",
            "name": "Weekly order"
        ],
        "items": [
            "0": [
                "name": "Hex bolt M8",
                "quantity": 100,
                "sku": "BOLT-M8-30",
                "unit_price": 0.12
            ]
        ]
    ], // optional
    profile_id: "", // optional
    session_key: "a1b2c3d4e5f6", // optional
    target_cart_id: "" // optional
)

```
