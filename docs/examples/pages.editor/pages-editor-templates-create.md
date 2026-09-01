```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let error = try await pagesEditor.pagesEditorTemplatesCreate(
    page_id: "",
    label: "Hero with two teasers",
    uuids: [],
    description: "Full-width hero followed by a two-column teaser row.", // optional
    fieldName: "content", // optional
    isDefault: true, // optional
    pageBundle: "standard" // optional
)

```
