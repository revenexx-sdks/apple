```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let orders = Orders(client)

let error = try await orders.ordersUpdate(
    id: "",
    billing_address: [
        "city": "Berlin",
        "company": "Beispiel Industrietechnik GmbH",
        "country": "DE",
        "name": "Anna Berger",
        "street": "Musterstraße 12",
        "zip": "10115"
    ], // optional
    buyer: [
        "company": "Beispiel Industrietechnik GmbH",
        "customer_number": "K-10042",
        "email": "anna.berger@example.com",
        "name": "Anna Berger"
    ], // optional
    customer_order_number: "PO-2026-0042", // optional
    metadata: [
        "erp_batch": "2026-W32"
    ], // optional
    shipping_address: [
        "city": "Berlin",
        "company": "Beispiel Industrietechnik GmbH",
        "country": "DE",
        "name": "Anna Berger",
        "street": "Musterstraße 12",
        "zip": "10115"
    ], // optional
    user_data: [
        "campaign": "spring-catalogue",
        "source": "webshop"
    ] // optional
)

```
