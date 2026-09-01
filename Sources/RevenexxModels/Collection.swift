import Foundation
import JSONCodable

/// A Typesense collection definition, passed through from Typesense. `name` is rewritten back to the tenant's public collection name.
open class Collection<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case default_sorting_field = "default_sorting_field"
        case enable_nested_fields = "enable_nested_fields"
        case fields = "fields"
        case name = "name"
        case num_documents = "num_documents"
        case data
    }

    /// 
    public let default_sorting_field: String?
    /// 
    public let enable_nested_fields: Bool?
    /// 
    public let fields: [CollectionField<T>]?
    /// The public collection name.
    public let name: String?
    /// Documents currently indexed.
    public let num_documents: Int?
    /// Additional properties
    public let data: T

    init(
        default_sorting_field: String?,
        enable_nested_fields: Bool?,
        fields: [CollectionField<T>]?,
        name: String?,
        num_documents: Int?,
        data: T
    ) {
        self.default_sorting_field = default_sorting_field
        self.enable_nested_fields = enable_nested_fields
        self.fields = fields
        self.name = name
        self.num_documents = num_documents
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.default_sorting_field = try container.decodeIfPresent(String.self, forKey: .default_sorting_field)
        self.enable_nested_fields = try container.decodeIfPresent(Bool.self, forKey: .enable_nested_fields)
        self.fields = try container.decodeIfPresent([CollectionField<T>].self, forKey: .fields)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.num_documents = try container.decodeIfPresent(Int.self, forKey: .num_documents)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(default_sorting_field, forKey: .default_sorting_field)
        try container.encodeIfPresent(enable_nested_fields, forKey: .enable_nested_fields)
        try container.encodeIfPresent(fields, forKey: .fields)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(num_documents, forKey: .num_documents)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "default_sorting_field": default_sorting_field as Any,
            "enable_nested_fields": enable_nested_fields as Any,
            "fields": fields?.map { $0.toMap() } as Any,
            "name": name as Any,
            "num_documents": num_documents as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> Collection {
        return Collection(
            default_sorting_field: map["default_sorting_field"] as? String,
            enable_nested_fields: map["enable_nested_fields"] as? Bool,
            fields: (map["fields"] as? [[String: Any]] ?? []).map { CollectionField.from(map: $0) },
            name: map["name"] as? String,
            num_documents: map["num_documents"] as? Int,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
