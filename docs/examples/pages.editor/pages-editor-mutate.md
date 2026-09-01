```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let mutationResponse = try await pagesEditor.pagesEditorMutate(
    page_id: "",
    plugin: "add",
    langcode: "de", // optional
    payload: [:] // optional
)

```
