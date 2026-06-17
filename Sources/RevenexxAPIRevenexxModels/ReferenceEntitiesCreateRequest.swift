import Foundation
import JSONCodable

/// 
open class ReferenceEntitiesCreateRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image = "image"
        case labels = "labels"
    }

    /// 
    public let code: String
    /// 
    public let image: String?
    /// 
    public let labels: [String: AnyCodable]?

    init(
        code: String,
        image: String?,
        labels: [String: AnyCodable]?
    ) {
        self.code = code
        self.image = image
        self.labels = labels
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decode(String.self, forKey: .code)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.labels = try container.decodeIfPresent([String: AnyCodable].self, forKey: .labels)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(labels, forKey: .labels)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "image": image as Any,
            "labels": labels as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ReferenceEntitiesCreateRequest {
        return ReferenceEntitiesCreateRequest(
            code: map["code"] as! String,
            image: map["image"] as? String,
            labels: map["labels"] as? [String: AnyCodable]
        )
    }
}
