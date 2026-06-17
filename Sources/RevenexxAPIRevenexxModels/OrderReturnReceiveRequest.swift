import Foundation
import JSONCodable

/// No payload — receiving is a pure state transition (registered → received).
open class OrderReturnReceiveRequest: Codable {}
