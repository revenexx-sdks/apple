```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let messaging = Messaging(client)

let error = try await messaging.templateUpdatePatch(
    id: "",
    body_html: "", // optional
    body_text: "", // optional
    content_sid: "", // optional
    design: [], // optional
    enabled: true, // optional
    layout_id: "", // optional
    markets: [], // optional
    message_class: .transactional, // optional
    subject: "", // optional
    test_mode: true, // optional
    title: "", // optional
    valid_from: "2026-01-01T12:00:00Z", // optional
    valid_until: "2026-01-01T12:00:00Z", // optional
    variable_defaults: [], // optional
    variables: [], // optional
    whatsapp_category: .marketing // optional
)

```
