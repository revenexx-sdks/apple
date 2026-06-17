import Foundation
import JSONCodable

/// AlgoScrypt
open class AlgoScrypt: Codable {

    enum CodingKeys: String, CodingKey {
        case costCpu = "costCpu"
        case costMemory = "costMemory"
        case costParallel = "costParallel"
        case length = "length"
        case type = "type"
    }

    /// CPU complexity of computed hash.
    public let costCpu: Int
    /// Memory complexity of computed hash.
    public let costMemory: Int
    /// Parallelization of computed hash.
    public let costParallel: Int
    /// Length used to compute hash.
    public let length: Int
    /// Algo type.
    public let type: String

    init(
        costCpu: Int,
        costMemory: Int,
        costParallel: Int,
        length: Int,
        type: String
    ) {
        self.costCpu = costCpu
        self.costMemory = costMemory
        self.costParallel = costParallel
        self.length = length
        self.type = type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.costCpu = try container.decode(Int.self, forKey: .costCpu)
        self.costMemory = try container.decode(Int.self, forKey: .costMemory)
        self.costParallel = try container.decode(Int.self, forKey: .costParallel)
        self.length = try container.decode(Int.self, forKey: .length)
        self.type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(costCpu, forKey: .costCpu)
        try container.encode(costMemory, forKey: .costMemory)
        try container.encode(costParallel, forKey: .costParallel)
        try container.encode(length, forKey: .length)
        try container.encode(type, forKey: .type)
    }

    public func toMap() -> [String: Any] {
        return [
            "costCpu": costCpu as Any,
            "costMemory": costMemory as Any,
            "costParallel": costParallel as Any,
            "length": length as Any,
            "type": type as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AlgoScrypt {
        return AlgoScrypt(
            costCpu: map["costCpu"] as! Int,
            costMemory: map["costMemory"] as! Int,
            costParallel: map["costParallel"] as! Int,
            length: map["length"] as! Int,
            type: map["type"] as! String
        )
    }
}
