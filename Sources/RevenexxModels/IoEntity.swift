import Foundation
import JSONCodable

/// One importable / exportable entity of an installed app.
open class IoEntity: Codable {

    enum CodingKeys: String, CodingKey {
        case app = "app"
        case entity = "entity"
        case label = "label"
        case table = "table"
        case vendor = "vendor"
    }

    /// 
    public let app: String?
    /// 
    public let entity: String?
    /// Humanised entity name for pickers.
    public let label: String?
    /// The physical table name Baseline provisioned.
    public let table: String?
    /// 
    public let vendor: String?

    init(
        app: String?,
        entity: String?,
        label: String?,
        table: String?,
        vendor: String?
    ) {
        self.app = app
        self.entity = entity
        self.label = label
        self.table = table
        self.vendor = vendor
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.app = try container.decodeIfPresent(String.self, forKey: .app)
        self.entity = try container.decodeIfPresent(String.self, forKey: .entity)
        self.label = try container.decodeIfPresent(String.self, forKey: .label)
        self.table = try container.decodeIfPresent(String.self, forKey: .table)
        self.vendor = try container.decodeIfPresent(String.self, forKey: .vendor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(app, forKey: .app)
        try container.encodeIfPresent(entity, forKey: .entity)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(table, forKey: .table)
        try container.encodeIfPresent(vendor, forKey: .vendor)
    }

    public func toMap() -> [String: Any] {
        return [
            "app": app as Any,
            "entity": entity as Any,
            "label": label as Any,
            "table": table as Any,
            "vendor": vendor as Any
        ]
    }

    public static func from(map: [String: Any] ) -> IoEntity {
        return IoEntity(
            app: map["app"] as? String,
            entity: map["entity"] as? String,
            label: map["label"] as? String,
            table: map["table"] as? String,
            vendor: map["vendor"] as? String
        )
    }
}
