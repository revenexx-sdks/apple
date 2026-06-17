import Foundation
import JSONCodable

/// blökkli MutationResponseLike: success flag plus the full re-materialized editor state.
open class MutationResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case success = "success"
        case violations = "violations"
    }

    /// Full editor state (see pages.editor.state).
    public let state: [String: AnyCodable]?
    /// 
    public let success: Bool?
    /// 
    public let violations: [Any]?

    init(
        state: [String: AnyCodable]?,
        success: Bool?,
        violations: [Any]?
    ) {
        self.state = state
        self.success = success
        self.violations = violations
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.state = try container.decodeIfPresent([String: AnyCodable].self, forKey: .state)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.violations = try container.decodeIfPresent([Any].self, forKey: .violations)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(violations, forKey: .violations)
    }

    public func toMap() -> [String: Any] {
        return [
            "state": state as Any,
            "success": success as Any,
            "violations": violations as Any
        ]
    }

    public static func from(map: [String: Any] ) -> MutationResponse {
        return MutationResponse(
            state: map["state"] as? [String: AnyCodable],
            success: map["success"] as? Bool,
            violations: map["violations"] as? [Any]
        )
    }
}
