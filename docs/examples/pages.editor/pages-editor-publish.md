```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let error = try await pagesEditor.pagesEditorPublish(
    page_id: "",
    force: true, // optional
    label: "Autumn campaign" // optional
)

```
