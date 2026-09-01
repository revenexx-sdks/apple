import Foundation
import JSONCodable

/// blökkli MutationResponseLike: whether the call was applied, plus the FULL re-materialized editor state — so a client never has to re-fetch after a change.
open class MutationResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case success = "success"
        case violations = "violations"
    }

    /// Everything the blökkli editor runs on, for one page in one language, materialized at the current point of the undo history. The theme adapter maps it 1:1 onto blökkli's MappedState.
    public let state: EditorState?
    /// Whether the change was applied.
    public let success: Bool?
    /// Why the call was refused, when `success` is false.
    public let violations: [[String: AnyCodable]]?

    init(
        state: EditorState?,
        success: Bool?,
        violations: [[String: AnyCodable]]?
    ) {
        self.state = state
        self.success = success
        self.violations = violations
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.state = try container.decodeIfPresent(EditorState.self, forKey: .state)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.violations = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .violations)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(violations, forKey: .violations)
    }

    public func toMap() -> [String: Any] {
        return [
            "state": state?.toMap() as Any,
            "success": success as Any,
            "violations": violations as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MutationResponse {
        return MutationResponse(
            state: EditorState.from(map: map["state"] as! [String: Any]),
            success: map["success"] as? Bool,
            violations: map["violations"] as? [[String: AnyCodable]]
        )
    }
}
