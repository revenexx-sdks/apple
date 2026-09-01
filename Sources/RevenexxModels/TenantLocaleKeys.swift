import Foundation
import JSONCodable

/// One locale somewhere in this tenant, its read and write keys, and the markets that asked for it.
open class TenantLocaleKeys: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case language = "language"
        case markets = "markets"
        case read = "read"
        case write = "write"
    }

    /// The locale this entry is about, as some market registered it.
    public let code: String?
    /// Its language part, which is also the key under language granularity.
    public let language: String?
    /// Codes of the markets that registered this locale, sorted — who a baseline translation written here is actually for. An editor that lists six inputs without saying who needs them invites translations nobody will ever read.
    public let markets: [String]?
    /// Keys to try in order until one holds text — the same resolved order the per-market answer gives, so a baseline value and a market value can never be keyed differently.
    public let read: [String]?
    /// A key inside a labels bag: a full locale ('de-DE') under regional granularity, a bare language ('de') under language granularity.
    public let write: String?

    init(
        code: String?,
        language: String?,
        markets: [String]?,
        read: [String]?,
        write: String?
    ) {
        self.code = code
        self.language = language
        self.markets = markets
        self.read = read
        self.write = write
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.markets = try container.decodeIfPresent([String].self, forKey: .markets)
        self.read = try container.decodeIfPresent([String].self, forKey: .read)
        self.write = try container.decodeIfPresent(String.self, forKey: .write)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(markets, forKey: .markets)
        try container.encodeIfPresent(read, forKey: .read)
        try container.encodeIfPresent(write, forKey: .write)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "language": language as Any,
            "markets": markets as Any,
            "read": read as Any,
            "write": write as Any
        ]
    }

    public static func from(map: [String: Any] ) -> TenantLocaleKeys {
        return TenantLocaleKeys(
            code: map["code"] as? String,
            language: map["language"] as? String,
            markets: map["markets"] as? [String],
            read: map["read"] as? [String],
            write: map["write"] as? String
        )
    }
}
