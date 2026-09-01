```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let pagesEditor = PagesEditor(client)

let result = try await pagesEditor.pagesEditorEditStates(
    status: .active, // optional
    limit: 1, // optional
    offset: 1 // optional
)

```
