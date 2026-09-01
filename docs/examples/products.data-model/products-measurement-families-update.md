```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsDataModel = ProductsDataModel(client)

let error = try await productsDataModel.productsMeasurementFamiliesUpdate(
    id: "",
    code: "weight", // optional
    labels: [
        "de": "Gewicht",
        "en": "Weight"
    ], // optional
    standard_unit: "kilogram", // optional
    units: [
        "0": [
            "code": "kilogram",
            "convert_factor": 1,
            "symbol": "kg"
        ],
        "1": [
            "code": "gram",
            "convert_factor": 0.001,
            "symbol": "g"
        ]
    ] // optional
)

```
