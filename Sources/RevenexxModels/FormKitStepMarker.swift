import Foundation
import JSONCodable

/// A Revenexx step marker. The storefront cuts the flat array at each marker and renders the nodes that follow it as one wizard step, then removes the marker before FormKit renders anything. A definition with no marker is a single-step form.
open class FormKitStepMarker<T : Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case kind = "kind"
        case title = "title"
        case data
    }

    /// Stable id for the step, so a client can address it.
    public let id: String?
    /// What the step is: 'fields' for a normal step, 'thankyou' for the confirmation panel shown after a successful submit.
    public let kind: String?
    /// The step heading the visitor reads.
    public let title: String?
    /// Additional properties
    public let data: T

    init(
        id: String?,
        kind: String?,
        title: String?,
        data: T
    ) {
        self.id = id
        self.kind = kind
        self.title = title
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(kind, forKey: .kind)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(data, forKey: .data)
    }

    public func toMap() -> [String: Any] {
        return [
            "id": id as Any,
            "kind": kind as Any,
            "title": title as Any,
            "data": try! JSONEncoder().encode(data)
        ]
    }

    public static func from(map: [String: Any] ) -> FormKitStepMarker {
        return FormKitStepMarker(
            id: map["id"] as? String,
            kind: map["kind"] as? String,
            title: map["title"] as? String,
            data: try! JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: map["data"] as? [String: Any] ?? map, options: []))
        )
    }
}
