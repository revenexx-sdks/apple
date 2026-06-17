import Foundation

open class RevenexxAPIRevenexxError : Swift.Error, Decodable {

    public let message: String
    public let code: Int?
    public let type: String?
    public let response: String

    init(message: String, code: Int? = nil, type: String? = nil, response: String = "") {
        self.message = message
        self.code = code
        self.type = type
        self.response = response
    }
}

extension RevenexxAPIRevenexxError: CustomStringConvertible {
    public var description: String {
        get {
            return self.message
        }
    }
}

extension RevenexxAPIRevenexxError: LocalizedError {
    public var errorDescription: String? {
        get {
            return self.message
        }
    }
}
