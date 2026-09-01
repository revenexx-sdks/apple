```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orderlists = Orderlists(client)

let error = try await orderlists.orderlistsKindsCreate(
    code: "reagents",
    title: "Reagent list",
    description: "Chemicals ordered against a standing lab protocol.", // optional
    descriptions: [
        "de": "Chemikalien, die nach einem festen Laborprotokoll bestellt werden.",
        "en": "Chemicals ordered against a standing lab protocol."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Reagenzienliste",
        "en": "Reagent list"
    ], // optional
    position: 2, // optional
    tone: .neutral // optional
)

```
