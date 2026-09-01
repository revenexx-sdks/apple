import Foundation
import JSONCodable

/// Which checkbox to flip.
open class PageCommentTaskRequest: Codable {

    enum CodingKeys: String, CodingKey {
        case taskIndex = "taskIndex"
    }

    /// The task item to toggle, counted in document order from 0. A comment with fewer tasks than that answers 400, and so does anything that is not a whole number at or above 0.
    public let taskIndex: Int

    init(
        taskIndex: Int
    ) {
        self.taskIndex = taskIndex
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.taskIndex = try container.decode(Int.self, forKey: .taskIndex)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(taskIndex, forKey: .taskIndex)
    }

    public func toMap() -> [String: Any] {
        return [
            "taskIndex": taskIndex as Any
        ]
    }

    public static func from(map: [String: Any] ) -> PageCommentTaskRequest {
        return PageCommentTaskRequest(
            taskIndex: map["taskIndex"] as! Int
        )
    }
}
