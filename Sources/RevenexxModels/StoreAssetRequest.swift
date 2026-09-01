import Foundation
import JSONCodable
import RevenexxEnums

/// 
open class StoreAssetRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case alt_text = "alt_text"
        case description = "description"
        case display_name = "display_name"
        case file = "file"
        case folder_id = "folder_id"
        case keep_archive = "keep_archive"
        case tags = "tags"
        case unpack = "unpack"
        case visibility = "visibility"
    }

    /// 
    public let alt_text: String?
    /// 
    public let description: String?
    /// 
    public let display_name: String?
    /// 
    public let file: String
    /// 
    public let folder_id: String?
    /// 
    public let keep_archive: Bool?
    /// 
    public let tags: [String]?
    /// Archives only: unpack the members after upload (see AssetController).
    public let unpack: Bool?
    /// 
    public let visibility: RevenexxEnums.StoreAssetRequestVisibility?

    init(
        alt_text: String?,
        description: String?,
        display_name: String?,
        file: String,
        folder_id: String?,
        keep_archive: Bool?,
        tags: [String]?,
        unpack: Bool?,
        visibility: RevenexxEnums.StoreAssetRequestVisibility?
    ) {
        self.alt_text = alt_text
        self.description = description
        self.display_name = display_name
        self.file = file
        self.folder_id = folder_id
        self.keep_archive = keep_archive
        self.tags = tags
        self.unpack = unpack
        self.visibility = visibility
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.alt_text = try container.decodeIfPresent(String.self, forKey: .alt_text)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.display_name = try container.decodeIfPresent(String.self, forKey: .display_name)
        self.file = try container.decode(String.self, forKey: .file)
        self.folder_id = try container.decodeIfPresent(String.self, forKey: .folder_id)
        self.keep_archive = try container.decodeIfPresent(Bool.self, forKey: .keep_archive)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
        self.unpack = try container.decodeIfPresent(Bool.self, forKey: .unpack)
        if let visibilityString = try container.decodeIfPresent(String.self, forKey: .visibility) {
            self.visibility = RevenexxEnums.StoreAssetRequestVisibility(rawValue: visibilityString)
        } else {
            self.visibility = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(alt_text, forKey: .alt_text)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(display_name, forKey: .display_name)
        try container.encode(file, forKey: .file)
        try container.encodeIfPresent(folder_id, forKey: .folder_id)
        try container.encodeIfPresent(keep_archive, forKey: .keep_archive)
        try container.encodeIfPresent(tags, forKey: .tags)
        try container.encodeIfPresent(unpack, forKey: .unpack)
        try container.encodeIfPresent(visibility?.rawValue, forKey: .visibility)
    }

    public func toMap() -> [String: Any] {
        return [
            "alt_text": alt_text as Any,
            "description": description as Any,
            "display_name": display_name as Any,
            "file": file as Any,
            "folder_id": folder_id as Any,
            "keep_archive": keep_archive as Any,
            "tags": tags as Any,
            "unpack": unpack as Any,
            "visibility": visibility?.rawValue as Any
        ]
    }

    public static func from(map: [String: Any] ) -> StoreAssetRequest {
        return StoreAssetRequest(
            alt_text: map["alt_text"] as? String,
            description: map["description"] as? String,
            display_name: map["display_name"] as? String,
            file: map["file"] as! String,
            folder_id: map["folder_id"] as? String,
            keep_archive: map["keep_archive"] as? Bool,
            tags: map["tags"] as? [String],
            unpack: map["unpack"] as? Bool,
            visibility: map["visibility"] as? String != nil ? StoreAssetRequestVisibility(rawValue: map["visibility"] as! String) : nil
        )
    }
}
