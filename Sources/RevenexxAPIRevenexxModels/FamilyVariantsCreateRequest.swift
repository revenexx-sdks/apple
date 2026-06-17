import Foundation
import JSONCodable

/// 
open class FamilyVariantsCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case axes = "axes"
        case code = "code"
        case family_id = "family_id"
        case labels = "labels"
    }

    /// 
    public let axes: [String: AnyCodable]?
    /// 
    public let code: String
    /// 
    public let family_id: String
    /// 
    public let labels: [String: AnyCodable]?

    init(
        axes: [String: AnyCodable]?,
        code: String,
        family_id: String,
        labels: [String: AnyCodable]?
    ) {
        self.axes = axes
        self.code = code
        self.family_id = family_id
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.axes = try container.decodeIfPresent([String: AnyCodable].self, forKey: .axes)
        self.code = try container.decode(String.self, forKey: .code)
        self.family_id = try container.decode(String.self, forKey: .family_id)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(axes, forKey: .axes)
        try container.encode(code, forKey: .code)
        try container.encode(family_id, forKey: .family_id)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "axes": axes as Any,
            "code": code as Any,
            "family_id": family_id as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FamilyVariantsCreateRequest {
        return FamilyVariantsCreateRequest(
            axes: map["axes"] as? [String: AnyCodable],
            code: map["code"] as! String,
            family_id: map["family_id"] as! String,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
