import Foundation
import JSONCodable

/// AlgoArgon2
open class AlgoArgon2: Codable {

    enum CodingKeys: String, CodingKey {
        case memoryCost = "memoryCost"
        case threads = "threads"
        case timeCost = "timeCost"
        case type = "type"
    }

    /// Memory used to compute hash.
    public let memoryCost: Int
    /// Number of threads used to compute hash.
    public let threads: Int
    /// Amount of time consumed to compute hash
    public let timeCost: Int
    /// Algo type.
    public let type: String

    init(
        memoryCost: Int,
        threads: Int,
        timeCost: Int,
        type: String
    ) {
        self.memoryCost = memoryCost
        self.threads = threads
        self.timeCost = timeCost
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.memoryCost = try container.decode(Int.self, forKey: .memoryCost)
        self.threads = try container.decode(Int.self, forKey: .threads)
        self.timeCost = try container.decode(Int.self, forKey: .timeCost)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(memoryCost, forKey: .memoryCost)
        try container.encode(threads, forKey: .threads)
        try container.encode(timeCost, forKey: .timeCost)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "memoryCost": memoryCost as Any,
            "threads": threads as Any,
            "timeCost": timeCost as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AlgoArgon2 {
        return AlgoArgon2(
            memoryCost: map["memoryCost"] as! Int,
            threads: map["threads"] as! Int,
            timeCost: map["timeCost"] as! Int,
            type: map["type"] as! String
        )
    }
}
