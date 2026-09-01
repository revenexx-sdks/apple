import Foundation

public enum AppsGetDeploymentDownloadType: String, CustomStringConvertible {
    case source = "source"
    case output = "output"

    public var description: String {
        return rawValue
    }
}
