```swift
import Revenexx
import RevenexxEnums

let client = Client()
    .setEndpoint("https://api.revenexx.com") // Your API Endpoint
    .setApiKeyAuth("<API_KEY>") // A gateway-managed scoped API key (rvxk_…).

let products = Products(client)

let error = try await products.productsCreate(
    sku: "ACME-4711-BLK",
    attribute_values: [
        "channel_locale_specific": [
            "b2b": [
                "de_DE": [
                    "description": "Staffelpreise auf Anfrage."
                ]
            ]
        ],
        "channel_specific": [
            "b2b": [
                "minimum_order_quantity": 6
            ]
        ],
        "common": [
            "colour": "black",
            "manufacturer_aid": "4711-BLK",
            "net_weight": 2.4
        ],
        "locale_specific": [
            "de_DE": [
                "description": "Bürstenloser Motor, 2 Akkus im Set.",
                "name": "Akku-Bohrschrauber 18V"
            ],
            "en_GB": [
                "name": "18V cordless drill"
            ]
        ]
    ], // optional
    completeness: [
        "computed_at": "2026-01-01T12:00:00Z",
        "filled": 9,
        "missing": [
            "0": "net_weight",
            "1": "packaging_unit",
            "2": "safety_datasheet"
        ],
        "ratio": 0.75,
        "required": 12
    ], // optional
    deleted_at: "2026-01-01T12:00:00Z", // optional
    enabled: true, // optional
    family_id: "", // optional
    family_variant_id: "", // optional
    kind: .simple, // optional
    parent_id: "", // optional
    quantified_associations: [
        "PRODUCT_SET": [
            "product_models": [:],
            "products": [
                "0": [
                    "identifier": "ACME-4711-CASTER",
                    "quantity": 4
                ]
            ]
        ]
    ], // optional
    tax_class: "standard" // optional
)

```
