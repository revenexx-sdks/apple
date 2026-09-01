import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class OrderReturnCompleteRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case resolution = "resolution"
    }

    /// How the return was settled. Omitted = settled without recording how.
    public let resolution: RevenexxEnums.OrderReturnSettlement?

    init(
        resolution: RevenexxEnums.OrderReturnSettlement?
    ) {
        self.resolution = resolution
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let resolutionString = try container.decodeIfPresent(String.self, forKey: .resolution) {
            self.resolution = RevenexxEnums.OrderReturnSettlement(rawValue: resolutionString)
        } else {
            self.resolution = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(resolution?.rawValue, forKey: .resolution)
    }

    public func toMap() -> [String: Any] {
        return [
            "resolution": resolution?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> OrderReturnCompleteRequest {
        return OrderReturnCompleteRequest(
            resolution: map["resolution"] as? String != nil ? OrderReturnSettlement(rawValue: map["resolution"] as! String) : nil
        )
    }
}
