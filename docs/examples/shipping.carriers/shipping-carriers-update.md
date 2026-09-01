```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let shippingCarriers = ShippingCarriers(client)

let error = try await shippingCarriers.shippingCarriersUpdate(
    id: "",
    code: "acme-parcel", // optional
    countries: ["DE","AT","CH"], // optional
    cutoff_time: "16:00", // optional
    eta_days_max: 1, // optional
    eta_days_min: 1, // optional
    handling_days: 1, // optional
    labels: [
        "de": "Acme Paketdienst",
        "en": "Acme Parcel"
    ], // optional
    metadata: [
        "contract": "ACME-2026",
        "customer_number": "4711"
    ], // optional
    name: "Acme Parcel", // optional
    position: 1, // optional
    service_level: "express", // optional
    status: .active, // optional
    tracking_url_template: "https://track.example.com/parcels/{tracking_code}" // optional
)

```
