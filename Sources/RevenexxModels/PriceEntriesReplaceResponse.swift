import Foundation
import JSONCodable

/// The list as it now stands: everything that was there is gone and these are the rows that took its place.
open class PriceEntriesReplaceResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case entries = "entries"
    }

    /// The complete new entry set, as stored — including the ids and timestamps the database filled in.
    public let entries: [PriceEntry]?

    init(
        entries: [PriceEntry]?
    ) {
        self.entries = entries
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.entries = try container.decodeIfPresent([PriceEntry].self, forKey: .entries)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(entries, forKey: .entries)
    }

    public func toMap() -> [String: Any] {
        return [
            "entries": entries?.map { $0.toMap() } as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PriceEntriesReplaceResponse {
        return PriceEntriesReplaceResponse(
            entries: (map["entries"] as? [[String: Any]] ?? []).map { PriceEntry.from(map: $0) }
        )
    }
}
