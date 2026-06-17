import Foundation
import JSONCodable

/// 
open class OrderReturnCompleteRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case resolution = "resolution"
    }

    /// How the return was settled (refund, replacement, …).
    public let resolution: String?

    init(
        resolution: String?
    ) {
        self.resolution = resolution
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(resolution, forKey: .resolution)
    }

    public func toMap() -> [String: Any] {
        return [
            "resolution": resolution as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnCompleteRequest {
        return OrderReturnCompleteRequest(
            resolution: map["resolution"] as? String
        )
    }
}
