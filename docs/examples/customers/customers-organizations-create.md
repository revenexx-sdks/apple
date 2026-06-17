```swift
import RevenexxAPIRevenexx
import RevenexxAPIRevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customers = Customers(client)

let organization = try await customers.customersOrganizationsCreate(
    name: "",
    settings: [:], // optional
    status: .active, // optional
    vat_id: "" // optional
)

```
