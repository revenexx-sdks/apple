import Foundation
import JSONCodable

/// Partial update — omitted fields keep their current value.
open class ReferenceEntityRecordsUpdateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case attribute_values = "attribute_values"
        case code = "code"
        case labels = "labels"
        case reference_entity_id = "reference_entity_id"
    }

    /// Every attribute value the record carries, in ONE jsonb document — the core of an attribute-driven PIM. A record's properties are not columns here: they are rows in `attributes`, selected per family by `family_attributes`, and their values live under their attribute CODE inside this object.
    /// 
    /// Four buckets, and an attribute's own flags decide which one it writes to:
    /// 
    ///   `common`                    the attribute is neither localizable nor scopable — one value, full stop.
    ///                               `{"common": {"net_weight": 2.4, "colour": "black"}}`
    ///   `locale_specific`           `localizable`: one value per language tag.
    ///                               `{"locale_specific": {"de_DE": {"name": "Akku-Bohrschrauber"}}}`
    ///   `channel_specific`          `scopable`: one value per channel.
    ///                               `{"channel_specific": {"b2b": {"minimum_order_quantity": 6}}}`
    ///   `channel_locale_specific`   both: one value per channel AND language tag.
    ///                               `{"channel_locale_specific": {"b2b": {"de_DE": {"description": "…"}}}}`
    /// 
    /// A reader takes the most specific bucket that carries the code and falls back through locale, then channel, then `common`. `common` is always last and always consulted, because early imports wrote everything there whatever an attribute's flags said — a reader that skipped it reports an imported catalog as empty. `GET /products/attribute-schema` answers, per field, the exact path a value belongs at (`storage.path`) and that full fallback order (`from`), so no client has to re-derive any of this.
    /// 
    /// The value itself is whatever the attribute's `type` implies: a string, a number, a boolean, an option CODE for a select (never its label), a list of codes for a multi-select, `{"amount": …, "unit": …}` for a measure, a list of `{"amount": …, "currency": …}` for a price, an asset code for media.
    /// 
    /// Defaults to `{}`, and an empty object is a normal state — a record nobody has enriched yet. The declared type also admits an array only because every jsonb column of this app shares one mapping; an array is not meaningful here and every reader in this app treats a non-object as empty.
    /// 
    /// Which attributes a record of this entity has comes from `attributes` rows with `entity_type: "reference_entity"` and `entity_ref` equal to the entity's code — `GET /products/attribute-schema?entity_type=reference_entity&entity_ref=brand` answers it in one call.
    public let attribute_values: [String: AnyCodable]?
    /// The record's stable identifier — the value a product stores when it points at this record, the same way a select stores an option code. Unique within the entity.
    public let code: String?
    /// What the record is called, per language tag — the text a picker shows while the code is what gets written.
    public let labels: [String: AnyCodable]?
    /// Which reference entity this record belongs to.
    public let reference_entity_id: String?

    init(
        attribute_values: [String: AnyCodable]?,
        code: String?,
        labels: [String: AnyCodable]?,
        reference_entity_id: String?
    ) {
        self.attribute_values = attribute_values
        self.code = code
        self.labels = labels
        self.reference_entity_id = reference_entity_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.attribute_values = try container.decodeIfPresent([String: AnyCodable].self, forKey: .attribute_values)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.reference_entity_id = try container.decodeIfPresent(String.self, forKey: .reference_entity_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(attribute_values, forKey: .attribute_values)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(reference_entity_id, forKey: .reference_entity_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "attribute_values": attribute_values as Any,
            "code": code as Any,
            "labels": labels as Any,
            "reference_entity_id": reference_entity_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntityRecordsUpdateRequest {
        return ReferenceEntityRecordsUpdateRequest(
            attribute_values: map["attribute_values"] as? [String: AnyCodable],
            code: map["code"] as? String,
            labels: map["labels"] as? [String: AnyCodable],
            reference_entity_id: map["reference_entity_id"] as? String
        )
    }
}
