```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let forms = Forms(client)

let error = try await forms.formsCreate(
    name: "Price request",
    slug: "price-request",
    definition: [{"$formkit":"text","label":"Company","name":"company","validation":"required"},{"$formkit":"email","label":"Email","name":"email","validation":"required|email"},{"$formkit":"textarea","label":"What do you need a price for?","name":"message","rows":4},{"$el":"p","children":"We answer price requests within one working day."}], // optional
    metadata: [:], // optional
    settings: [:], // optional
    status: .draft // optional
)

```
