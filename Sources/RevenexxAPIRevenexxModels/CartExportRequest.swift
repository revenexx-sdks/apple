import Foundation
import JSONCodable
import RevenexxAPIRevenexxEnums

/// 
open class CartExportRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case format = "format"
        case profile_id = "profile_id"
    }

    /// Ad-hoc export format (only without profile_id).
    public let format: Revenexx API — revenexxEnums.CartExportFormat?
    /// Export profile to run; ad-hoc JSON/CSV export when omitted.
    public let profile_id: String?

    init(
        format: Revenexx API — revenexxEnums.CartExportFormat?,
        profile_id: String?
    ) {
        self.format = format
        self.profile_id = profile_id
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let formatString = try container.decodeIfPresent(String.self, forKey: .format) {
            self.format = Revenexx API — revenexxEnums.CartExportFormat(rawValue: formatString)
        } else {
            self.format = nil
        }
        self.profile_id = try container.decodeIfPresent(String.self, forKey: .profile_id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(format?.rawValue, forKey: .format)
        try container.encodeIfPresent(profile_id, forKey: .profile_id)
    }

    public func toMap() -> [String: Any] {
        return [
            "format": format?.rawValue as Any,
            "profile_id": profile_id as Any
        ]
    }

    public static func from(map: [String: Any] ) -> CartExportRequest {
        return CartExportRequest(
            format: map["format"] as? String != nil ? CartExportFormat(rawValue: map["format"] as! String) : nil,
            profile_id: map["profile_id"] as? String
        )
    }
}
