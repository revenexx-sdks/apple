import Foundation
import JSONCodable

/// Documents List
open class DocumentList<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case documents = "documents"
        case total = "total"
    }

    /// List of documents.
    public let documents: [Document<T>]
    /// Total number of documents that matched your query.
    public let total: Int

    init(
        documents: [Document<T>],
        total: Int
    ) {
        self.documents = documents
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.documents = try container.decode([Document<T>].self, forKey: .documents)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(documents, forKey: .documents)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "documents": documents.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> DocumentList {
        return DocumentList(
            documents: (map["documents"] as! [[String: Any]]).map { Document.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
