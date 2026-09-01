```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let forms = Forms(client)

let error = try await forms.formsList(
    id: "", // optional
    name: "Contact request", // optional
    slug: "contact", // optional
    status: .draft, // optional
    created_at: "2026-01-31T09:15:00Z", // optional
    updated_at: "2026-01-31T09:15:00Z", // optional
    limit: 50, // optional
    offset: 0, // optional
    order: "created_at.desc" // optional
)

```
