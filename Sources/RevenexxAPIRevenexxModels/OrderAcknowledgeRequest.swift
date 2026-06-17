import Foundation
import JSONCodable

/// 
open class OrderAcknowledgeRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case external_ref = "external_ref"
    }

    /// The fulfilling system&#039;s order reference (e.g. the ERP order number).
    public let external_ref: String?

    init(
        external_ref: String?
    ) {
        self.external_ref = external_ref
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.external_ref = try container.decodeIfPresent(String.self, forKey: .external_ref)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(external_ref, forKey: .external_ref)
    }

    public func toMap() -> [String: Any] {
        return [
            "external_ref": external_ref as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderAcknowledgeRequest {
        return OrderAcknowledgeRequest(
            external_ref: map["external_ref"] as? String
        )
    }
}
