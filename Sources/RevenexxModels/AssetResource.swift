import Foundation
import JSONCodable

/// 
open class AssetResource: Codable {

    enum CodingKeys: String, CodingKey {
        case alt_text = "alt_text"
        case content_hash = "content_hash"
        case created_at = "created_at"
        case deleted_at = "deleted_at"
        case description = "description"
        case display_name = "display_name"
        case dominant_color = "dominant_color"
        case duration_ms = "duration_ms"
        case folder_id = "folder_id"
        case height = "height"
        case id = "id"
        case kind = "kind"
        case metadata = "metadata"
        case mime_type = "mime_type"
        case model_url = "model_url"
        case original_name = "original_name"
        case page_count = "page_count"
        case path_name = "path_name"
        case preview_url = "preview_url"
        case processed_at = "processed_at"
        case size_bytes = "size_bytes"
        case status = "status"
        case tags = "tags"
        case tenant_id = "tenant_id"
        case updated_at = "updated_at"
        case url = "url"
        case usdz_url = "usdz_url"
        case visibility = "visibility"
        case width = "width"
    }

    /// 
    public let alt_text: String
    /// 
    public let content_hash: String
    /// 
    public let created_at: String
    /// 
    public let deleted_at: String
    /// 
    public let description: String
    /// 
    public let display_name: String
    /// 
    public let dominant_color: String
    /// 
    public let duration_ms: Int
    /// 
    public let folder_id: String
    /// 
    public let height: Int
    /// 
    public let id: String
    /// 
    public let kind: String
    /// 
    public let metadata: [AnyCodable]
    /// 
    public let mime_type: String
    /// 
    public let model_url: String
    /// 
    public let original_name: String
    /// 
    public let page_count: Int
    /// 
    public let path_name: String
    /// 3D derivatives (null unless rendered): preview image + .glb mesh.
    public let preview_url: String
    /// 
    public let processed_at: String
    /// 
    public let size_bytes: Int
    /// 
    public let status: String
    /// 
    public let tags: [AnyCodable]
    /// 
    public let tenant_id: String
    /// 
    public let updated_at: String
    /// Null for a private asset — it is only reachable through a signed
    /// URL, so there is no path-addressed public URL to hand out.
    public let url: String
    /// 
    public let usdz_url: String
    /// 
    public let visibility: String
    /// 
    public let width: Int

    init(
        alt_text: String,
        content_hash: String,
        created_at: String,
        deleted_at: String,
        description: String,
        display_name: String,
        dominant_color: String,
        duration_ms: Int,
        folder_id: String,
        height: Int,
        id: String,
        kind: String,
        metadata: [AnyCodable],
        mime_type: String,
        model_url: String,
        original_name: String,
        page_count: Int,
        path_name: String,
        preview_url: String,
        processed_at: String,
        size_bytes: Int,
        status: String,
        tags: [AnyCodable],
        tenant_id: String,
        updated_at: String,
        url: String,
        usdz_url: String,
        visibility: String,
        width: Int
    ) {
        self.alt_text = alt_text
        self.content_hash = content_hash
        self.created_at = created_at
        self.deleted_at = deleted_at
        self.description = description
        self.display_name = display_name
        self.dominant_color = dominant_color
        self.duration_ms = duration_ms
        self.folder_id = folder_id
        self.height = height
        self.id = id
        self.kind = kind
        self.metadata = metadata
        self.mime_type = mime_type
        self.model_url = model_url
        self.original_name = original_name
        self.page_count = page_count
        self.path_name = path_name
        self.preview_url = preview_url
        self.processed_at = processed_at
        self.size_bytes = size_bytes
        self.status = status
        self.tags = tags
        self.tenant_id = tenant_id
        self.updated_at = updated_at
        self.url = url
        self.usdz_url = usdz_url
        self.visibility = visibility
        self.width = width
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.alt_text = try container.decode(String.self, forKey: .alt_text)
        self.content_hash = try container.decode(String.self, forKey: .content_hash)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.deleted_at = try container.decode(String.self, forKey: .deleted_at)
        self.description = try container.decode(String.self, forKey: .description)
        self.display_name = try container.decode(String.self, forKey: .display_name)
        self.dominant_color = try container.decode(String.self, forKey: .dominant_color)
        self.duration_ms = try container.decode(Int.self, forKey: .duration_ms)
        self.folder_id = try container.decode(String.self, forKey: .folder_id)
        self.height = try container.decode(Int.self, forKey: .height)
        self.id = try container.decode(String.self, forKey: .id)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.metadata = try container.decode([AnyCodable].self, forKey: .metadata)
        self.mime_type = try container.decode(String.self, forKey: .mime_type)
        self.model_url = try container.decode(String.self, forKey: .model_url)
        self.original_name = try container.decode(String.self, forKey: .original_name)
        self.page_count = try container.decode(Int.self, forKey: .page_count)
        self.path_name = try container.decode(String.self, forKey: .path_name)
        self.preview_url = try container.decode(String.self, forKey: .preview_url)
        self.processed_at = try container.decode(String.self, forKey: .processed_at)
        self.size_bytes = try container.decode(Int.self, forKey: .size_bytes)
        self.status = try container.decode(String.self, forKey: .status)
        self.tags = try container.decode([AnyCodable].self, forKey: .tags)
        self.tenant_id = try container.decode(String.self, forKey: .tenant_id)
        self.updated_at = try container.decode(String.self, forKey: .updated_at)
        self.url = try container.decode(String.self, forKey: .url)
        self.usdz_url = try container.decode(String.self, forKey: .usdz_url)
        self.visibility = try container.decode(String.self, forKey: .visibility)
        self.width = try container.decode(Int.self, forKey: .width)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(alt_text, forKey: .alt_text)
        try container.encode(content_hash, forKey: .content_hash)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(deleted_at, forKey: .deleted_at)
        try container.encode(description, forKey: .description)
        try container.encode(display_name, forKey: .display_name)
        try container.encode(dominant_color, forKey: .dominant_color)
        try container.encode(duration_ms, forKey: .duration_ms)
        try container.encode(folder_id, forKey: .folder_id)
        try container.encode(height, forKey: .height)
        try container.encode(id, forKey: .id)
        try container.encode(kind, forKey: .kind)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(mime_type, forKey: .mime_type)
        try container.encode(model_url, forKey: .model_url)
        try container.encode(original_name, forKey: .original_name)
        try container.encode(page_count, forKey: .page_count)
        try container.encode(path_name, forKey: .path_name)
        try container.encode(preview_url, forKey: .preview_url)
        try container.encode(processed_at, forKey: .processed_at)
        try container.encode(size_bytes, forKey: .size_bytes)
        try container.encode(status, forKey: .status)
        try container.encode(tags, forKey: .tags)
        try container.encode(tenant_id, forKey: .tenant_id)
        try container.encode(updated_at, forKey: .updated_at)
        try container.encode(url, forKey: .url)
        try container.encode(usdz_url, forKey: .usdz_url)
        try container.encode(visibility, forKey: .visibility)
        try container.encode(width, forKey: .width)
    }

    public func toMap() -> [String: Any] {
        return [
            "alt_text": alt_text as Any,
            "content_hash": content_hash as Any,
            "created_at": created_at as Any,
            "deleted_at": deleted_at as Any,
            "description": description as Any,
            "display_name": display_name as Any,
            "dominant_color": dominant_color as Any,
            "duration_ms": duration_ms as Any,
            "folder_id": folder_id as Any,
            "height": height as Any,
            "id": id as Any,
            "kind": kind as Any,
            "metadata": metadata as Any,
            "mime_type": mime_type as Any,
            "model_url": model_url as Any,
            "original_name": original_name as Any,
            "page_count": page_count as Any,
            "path_name": path_name as Any,
            "preview_url": preview_url as Any,
            "processed_at": processed_at as Any,
            "size_bytes": size_bytes as Any,
            "status": status as Any,
            "tags": tags as Any,
            "tenant_id": tenant_id as Any,
            "updated_at": updated_at as Any,
            "url": url as Any,
            "usdz_url": usdz_url as Any,
            "visibility": visibility as Any,
            "width": width as Any
        ]
    }

    public static func from(map: [String: Any] ) -> AssetResource {
        return AssetResource(
            alt_text: map["alt_text"] as! String,
            content_hash: map["content_hash"] as! String,
            created_at: map["created_at"] as! String,
            deleted_at: map["deleted_at"] as! String,
            description: map["description"] as! String,
            display_name: map["display_name"] as! String,
            dominant_color: map["dominant_color"] as! String,
            duration_ms: map["duration_ms"] as! Int,
            folder_id: map["folder_id"] as! String,
            height: map["height"] as! Int,
            id: map["id"] as! String,
            kind: map["kind"] as! String,
            metadata: (map["metadata"] as! [Any]).map { AnyCodable($0) },
            mime_type: map["mime_type"] as! String,
            model_url: map["model_url"] as! String,
            original_name: map["original_name"] as! String,
            page_count: map["page_count"] as! Int,
            path_name: map["path_name"] as! String,
            preview_url: map["preview_url"] as! String,
            processed_at: map["processed_at"] as! String,
            size_bytes: map["size_bytes"] as! Int,
            status: map["status"] as! String,
            tags: (map["tags"] as! [Any]).map { AnyCodable($0) },
            tenant_id: map["tenant_id"] as! String,
            updated_at: map["updated_at"] as! String,
            url: map["url"] as! String,
            usdz_url: map["usdz_url"] as! String,
            visibility: map["visibility"] as! String,
            width: map["width"] as! Int
        )
    }
}
