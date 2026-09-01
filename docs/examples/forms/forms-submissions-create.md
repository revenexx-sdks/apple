```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let forms = Forms(client)

let error = try await forms.formsSubmissionsCreate(
    data: [
        "company": "Example GmbH",
        "email": "buyer@example.com",
        "message": "Please quote 200 units of ACME-4711-BLK, delivered to Hamburg."
    ],
    form_id: "",
    form_slug: "contact", // optional
    metadata: [:], // optional
    source: "/contact", // optional
    status: .new // optional
)

```
