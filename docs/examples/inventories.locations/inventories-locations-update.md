```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let inventoriesLocations = InventoriesLocations(client)

let error = try await inventoriesLocations.inventoriesLocationsUpdate(
    id: "",
    address: [
        "city": "Nuremberg",
        "country": "DE",
        "postal_code": "90402",
        "street": "Industriering 4"
    ], // optional
    code: "main", // optional
    enabled: true, // optional
    labels: [
        "de": "Hauptlager",
        "en": "Main warehouse"
    ], // optional
    metadata: [
        "erp_site": "1000"
    ], // optional
    name: "Main warehouse", // optional
    priority: 0, // optional
    type: .warehouse // optional
)

```
