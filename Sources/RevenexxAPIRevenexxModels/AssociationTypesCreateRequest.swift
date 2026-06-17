import Foundation
import JSONCodable

/// 
open class AssociationTypesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case is_quantified = "is_quantified"
        case is_two_way = "is_two_way"
        case labels = "labels"
    }

    /// 
    public let code: String
    /// 
    public let is_quantified: Bool?
    /// 
    public let is_two_way: Bool?
    /// 
    public let labels: [String: AnyCodable]?

    init(
        code: String,
        is_quantified: Bool?,
        is_two_way: Bool?,
        labels: [String: AnyCodable]?
    ) {
        self.code = code
        self.is_quantified = is_quantified
        self.is_two_way = is_two_way
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.is_quantified = try container.decodeIfPresent(Bool.self, forKey: .is_quantified)
        self.is_two_way = try container.decodeIfPresent(Bool.self, forKey: .is_two_way)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(is_quantified, forKey: .is_quantified)
        try container.encodeIfPresent(is_two_way, forKey: .is_two_way)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "is_quantified": is_quantified as Any,
            "is_two_way": is_two_way as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AssociationTypesCreateRequest {
        return AssociationTypesCreateRequest(
            code: map["code"] as! String,
            is_quantified: map["is_quantified"] as? Bool,
            is_two_way: map["is_two_way"] as? Bool,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
