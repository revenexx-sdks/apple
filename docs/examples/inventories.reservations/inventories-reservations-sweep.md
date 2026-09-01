```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesReservations = InventoriesReservations(client)

let reservationSweepResult = try await inventoriesReservations.inventoriesReservationsSweep(
    data: [:]
)

```
