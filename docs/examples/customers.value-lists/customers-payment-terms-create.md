```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let customersValueLists = CustomersValueLists(client)

let error = try await customersValueLists.customersPaymentTermsCreate(
    code: "",
    title: "Net 30 days",
    description: "Invoice due 30 days after the delivery note.", // optional
    descriptions: [
        "de": "Rechnung 30 Tage nach Lieferschein fällig.",
        "en": "Invoice due 30 days after the delivery note."
    ], // optional
    is_default: true, // optional
    labels: [
        "de": "Zahlbar in 30 Tagen",
        "en": "Net 30 days"
    ], // optional
    position: 1, // optional
    tone: .neutral // optional
)

```
