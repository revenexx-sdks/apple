```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersContacts = CustomersContacts(client)

let error = try await customersContacts.customersContactsCreate(
    email: "einkauf@example.com",
    first_name: "Anna", // optional
    is_primary: true, // optional
    job_title: "Einkaufsleitung", // optional
    last_name: "Berger", // optional
    locale: "de-DE", // optional
    order_approval_limit: 25000, // optional
    organization_id: "", // optional
    phone: "+49 30 5550123", // optional
    registration_status: .pending, // optional
    role: "buyer", // optional
    status: .invited // optional
)

```
