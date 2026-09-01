```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersContacts = CustomersContacts(client)

let result = try await customersContacts.customersContactEventsList(
    id: "", // optional
    contact_id: "", // optional
    organization_id: "", // optional
    kind: "call", // optional
    name: "activity.call", // optional
    subject: "Called about the annual requirement", // optional
    actor: "vertrieb@example.com", // optional
    occurred_at: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
