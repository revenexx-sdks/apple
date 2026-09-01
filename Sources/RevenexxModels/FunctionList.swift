import Foundation
import JSONCodable

/// Functions List
open class FunctionList: Codable {

    enum CodingKeys: String, CodingKey {
        case functions = "functions"
        case total = "total"
    }

    /// List of functions.
    public let functions: [Function]
    /// Total number of functions that matched your query.
    public let total: Int

    init(
        functions: [Function],
        total: Int
    ) {
        self.functions = functions
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.functions = try container.decode([Function].self, forKey: .functions)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(functions, forKey: .functions)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "functions": functions.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FunctionList {
        return FunctionList(
            functions: (map["functions"] as! [[String: Any]]).map { Function.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
