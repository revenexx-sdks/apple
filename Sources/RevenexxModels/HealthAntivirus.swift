import Foundation
import JSONCodable
import RevenexxEnums

/// Health Antivirus
open class HealthAntivirus: Codable {

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case version = "version"
    }

    /// Antivirus status. Possible values are: `disabled`, `offline`, `online`
    public let status: RevenexxEnums.HealthAntivirusStatus
    /// Antivirus version.
    public let version: String

    init(
        status: RevenexxEnums.HealthAntivirusStatus,
        version: String
    ) {
        self.status = status
        self.version = version
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.status = RevenexxEnums.HealthAntivirusStatus(rawValue: try container.decode(String.self, forKey: .status))!
        self.version = try container.decode(String.self, forKey: .version)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(status.rawValue, forKey: .status)
        try container.encode(version, forKey: .version)
    }

    public func toMap() -> [String: Any] {
        return [
            "status": status.rawValue as Any,
            "version": version as Any
        ]
    }

    public static func from(map: [String: Any] ) -> HealthAntivirus {
        return HealthAntivirus(
            status: HealthAntivirusStatus(rawValue: map["status"] as! String)!,
            version: map["version"] as! String
        )
    }
}
