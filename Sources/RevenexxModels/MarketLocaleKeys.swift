import Foundation
import JSONCodable

/// The read and write keys for one of the market's locales, already resolved from the two settings.
open class MarketLocaleKeys: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case language = "language"
        case read = "read"
        case write = "write"
    }

    /// The market's locale this entry is about.
    public let code: String?
    /// Its language part, which is also the key under language granularity.
    public let language: String?
    /// Keys to try in order until one holds text. Always starts at the exact code: a fallback fills a gap, it never outranks a stored value.
    public let read: [String]?
    /// A key inside a labels bag: a full locale ('de-DE') under regional granularity, a bare language ('de') under language granularity.
    public let write: String?

    init(
        code: String?,
        language: String?,
        read: [String]?,
        write: String?
    ) {
        self.code = code
        self.language = language
        self.read = read
        self.write = write
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.read = try container.decodeIfPresent([String].self, forKey: .read)
        self.write = try container.decodeIfPresent(String.self, forKey: .write)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(language, forKey: .language)
        try container.encodeIfPresent(read, forKey: .read)
        try container.encodeIfPresent(write, forKey: .write)
    }

    public func toMap() -> [String: Any] {
        return [
            "code": code as Any,
            "language": language as Any,
            "read": read as Any,
            "write": write as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MarketLocaleKeys {
        return MarketLocaleKeys(
            code: map["code"] as? String,
            language: map["language"] as? String,
            read: map["read"] as? [String],
            write: map["write"] as? String
        )
    }
}
