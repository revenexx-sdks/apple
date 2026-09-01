```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let editorState = try await pagesEditor.pagesEditorState(
    page_id: "",
    langcode: "de", // optional
    index: 1 // optional
)

```
