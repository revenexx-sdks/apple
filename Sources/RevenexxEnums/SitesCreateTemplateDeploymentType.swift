import Foundation

public enum SitesCreateTemplateDeploymentType: String, CustomStringConvertible {
    case branch = "branch"
    case commit = "commit"
    case tag = "tag"

    public var description: String {
        return rawValue
    }
}
