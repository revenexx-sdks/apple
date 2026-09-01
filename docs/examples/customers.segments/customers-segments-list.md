```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersSegments = CustomersSegments(client)

let result = try await customersSegments.customersSegmentsList(
    id: "", // optional
    code: "key_accounts", // optional
    position: 1, // optional
    rule_match: .all, // optional
    rules_computed_at: "2026-01-01T12:00:00Z", // optional
    created_at: "2026-01-01T12:00:00Z", // optional
    updated_at: "2026-01-01T12:00:00Z", // optional
    limit: 1, // optional
    offset: 1, // optional
    order: "created_at.desc" // optional
)

```
