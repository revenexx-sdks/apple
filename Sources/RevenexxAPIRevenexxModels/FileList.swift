import Foundation
import JSONCodable

/// Files List
open class FileList: Codable {

    enum CodingKeys: String, CodingKey {
        case files = "files"
        case total = "total"
    }

    /// List of files.
    public let files: [File]
    /// Total number of files that matched your query.
    public let total: Int

    init(
        files: [File],
        total: Int
    ) {
        self.files = files
        self.total = total
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.files = try container.decode([File].self, forKey: .files)
        self.total = try container.decode(Int.self, forKey: .total)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(files, forKey: .files)
        try container.encode(total, forKey: .total)
    }

    public func toMap() -> [String: Any] {
        return [
            "files": files.map { $0.toMap() } as Any,
            "total": total as Any
        ]
    }

    public static func from(map: [String: Any] ) -> FileList {
        return FileList(
            files: (map["files"] as! [[String: Any]]).map { File.from(map: $0) },
            total: map["total"] as! Int
        )
    }
}
