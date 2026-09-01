```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersContacts = CustomersContacts(client)

let result = try await customersContacts.customersContactsList(
    id: "", // optional
    organization_id: "", // optional
    email: "einkauf@example.com", // optional
    first_name: "Anna", // optional
    last_name: "Berger", // optional
    phone: "+49 30 5550123", // optional
    job_title: "Einkaufsleitung", // optional
    role: "buyer", // optional
    status: .invited, // optional
    order_approval_limit: 9.99, // optional
    registration_status: .pending, // optional
    registration_decided_at: "2026-01-01T12:00:00Z", // optional
    registration_decided_by: "vertrieb@example.com", // optional
    registration_reason: "Could not be verified as a commercial buyer.", // optional
    locale: "de-DE", // optional
    is_primary: true, // optional
    external_user_id: "", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
