```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let prices = Prices(client)

let error = try await prices.pricesEntriesAdjust(
    list_id: "",
    amount: 9.99, // optional
    dry_run: true, // optional
    percent: 9.99, // optional
    rounding: .exact, // optional
    sku_prefix: "BOLT-" // optional
)

```
