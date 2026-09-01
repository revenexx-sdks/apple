```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let markets = Markets(client)

let error = try await markets.marketsClone(
    id: "northwind",
    code: "northwind-b2b",
    copy_currencies: true, // optional
    copy_locales: true, // optional
    copy_tax_classes: true, // optional
    currency: "EUR", // optional
    name: "Northwind B2B", // optional
    status: .active // optional
)

```
