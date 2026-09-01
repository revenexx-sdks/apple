```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersContacts = CustomersContacts(client)

let error = try await customersContacts.customersOrganizationsEventsCreate(
    organization_id: "",
    contact_id: "",
    subject: "Called about the annual requirement",
    actor: "vertrieb@example.com", // optional
    kind: .note, // optional
    note: "Asked for a quote on the annual bolt requirement; call back in week 34.", // optional
    occurred_at: "2026-01-01T12:00:00Z" // optional
)

```
