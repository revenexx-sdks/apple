```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let error = try await pagesEditor.pagesEditorSchedule(
    page_id: "",
    scheduledAt: "2026-01-01T12:00:00Z"
)

```
