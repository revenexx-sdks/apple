import Foundation

public enum AppsCreateVcsDeploymentType: String, CustomStringConvertible {
    case branch = "branch"
    case commit = "commit"

    public var description: String {
        return rawValue
    }
}
