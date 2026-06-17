import Foundation
import JSONCodable

/// 
open class AttributeGroupsCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case labels = "labels"
        case position = "position"
    }

    /// 
    public let code: String
    /// 
    public let labels: [String: AnyCodable]?
    /// 
    public let position: Int?

    init(
        code: String,
        labels: [String: AnyCodable]?,
        position: Int?
    ) {
        self.code = code
        self.labels = labels
        self.position = position
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(position, forKey: .position)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "labels": labels as Any,
            "position": position as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AttributeGroupsCreateRequest {
        return AttributeGroupsCreateRequest(
            code: map["code"] as! String,
            labels: map["labels"] as? [String: AnyCodable],
            position: map["position"] as? Int
        )
    }
}
