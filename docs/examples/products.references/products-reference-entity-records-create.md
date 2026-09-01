```swift
import Revenexx

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let productsReferences = ProductsReferences(client)

let error = try await productsReferences.productsReferenceEntityRecordsCreate(
    code: "acme_tools",
    reference_entity_id: "",
    attribute_values: [
        "common": [
            "country": "DE",
            "founded": 1946
        ],
        "locale_specific": [
            "de_DE": [
                "description": "Werkzeughersteller aus Süddeutschland."
            ]
        ]
    ], // optional
    labels: [
        "de": "Acme Tools",
        "en": "Acme Tools"
    ] // optional
)

```
