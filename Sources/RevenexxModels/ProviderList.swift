import Foundation
import JSONCodable

/// Provider list
open class ProviderList: Codable {

    enum CodingKeys: String, CodingKey {
        case providers = "providers"
        case total = "total"
    }

    /// List of providers.
    public let providers: [Provider]
    /// Total number of providers that matched your query.
    public let total: Int

    init(
        providers: [Provider],
        total: Int
    ) {
        self.providers = providers
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.providers = try container.decode([Provider].self, forKey: .providers)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(providers, forKey: .providers)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "providers": providers.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> ProviderList {
        return ProviderList(
            providers: (map["providers"] as! [[String: Any]]).map { Provider.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
