```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let forms = Forms(client)

let error = try await forms.formsSubmissionsPrune(
    dry_run: true, // optional
    form_slug: "contact", // optional
    older_than_days: 1, // optional
    status: .new // optional
)

```
