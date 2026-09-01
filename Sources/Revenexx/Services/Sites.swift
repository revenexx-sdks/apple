import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Static sites and their deployments.
open class Sites: Service {

    ///
    /// Get a list of all the project's sites. You can use the query params to
    /// filter your results.
    ///
    /// - Parameters:
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.SiteList
    ///
    open func sitesList(
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.SiteList {
        let apiPath: String = "/v1/sites"

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.SiteList = { response in
            return RevenexxModels.SiteList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new site.
    ///
    /// - Parameters:
    ///   - buildRuntime: RevenexxEnums.BuildRuntime
    ///   - framework: RevenexxEnums.Framework
    ///   - name: String
    ///   - siteId: String
    ///   - adapter: RevenexxEnums.Adapter (optional)
    ///   - buildCommand: String (optional)
    ///   - enabled: Bool (optional)
    ///   - fallbackFile: String (optional)
    ///   - installCommand: String (optional)
    ///   - installationId: String (optional)
    ///   - logging: Bool (optional)
    ///   - outputDirectory: String (optional)
    ///   - providerBranch: String (optional)
    ///   - providerRepositoryId: String (optional)
    ///   - providerRootDirectory: String (optional)
    ///   - providerSilentMode: Bool (optional)
    ///   - specification: String (optional)
    ///   - timeout: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Site
    ///
    open func sitesCreate(
        buildRuntime: RevenexxEnums.BuildRuntime,
        framework: RevenexxEnums.Framework,
        name: String,
        siteId: String,
        adapter: RevenexxEnums.Adapter? = nil,
        buildCommand: String? = nil,
        enabled: Bool? = nil,
        fallbackFile: String? = nil,
        installCommand: String? = nil,
        installationId: String? = nil,
        logging: Bool? = nil,
        outputDirectory: String? = nil,
        providerBranch: String? = nil,
        providerRepositoryId: String? = nil,
        providerRootDirectory: String? = nil,
        providerSilentMode: Bool? = nil,
        specification: String? = nil,
        timeout: Int? = nil
    ) async throws -> RevenexxModels.Site {
        let apiPath: String = "/v1/sites"

        let apiParams: [String: Any?] = [
            "adapter": adapter,
            "buildCommand": buildCommand,
            "buildRuntime": buildRuntime,
            "enabled": enabled,
            "fallbackFile": fallbackFile,
            "framework": framework,
            "installCommand": installCommand,
            "installationId": installationId,
            "logging": logging,
            "name": name,
            "outputDirectory": outputDirectory,
            "providerBranch": providerBranch,
            "providerRepositoryId": providerRepositoryId,
            "providerRootDirectory": providerRootDirectory,
            "providerSilentMode": providerSilentMode,
            "siteId": siteId,
            "specification": specification,
            "timeout": timeout
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Site = { response in
            return RevenexxModels.Site.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all frameworks that are currently available on the server
    /// instance.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.FrameworkList
    ///
    open func sitesListFrameworks(
    ) async throws -> RevenexxModels.FrameworkList {
        let apiPath: String = "/v1/sites/frameworks"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.FrameworkList = { response in
            return RevenexxModels.FrameworkList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// List allowed site specifications for this instance.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.SpecificationList
    ///
    open func sitesListSpecifications(
    ) async throws -> RevenexxModels.SpecificationList {
        let apiPath: String = "/v1/sites/specifications"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.SpecificationList = { response in
            return RevenexxModels.SpecificationList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a site by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func sitesDelete(
        siteId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/sites/{siteId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a site by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Site
    ///
    open func sitesGet(
        siteId: String
    ) async throws -> RevenexxModels.Site {
        let apiPath: String = "/v1/sites/{siteId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Site = { response in
            return RevenexxModels.Site.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update site by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - framework: RevenexxEnums.Framework
    ///   - name: String
    ///   - adapter: RevenexxEnums.Adapter (optional)
    ///   - buildCommand: String (optional)
    ///   - buildRuntime: RevenexxEnums.BuildRuntime (optional)
    ///   - enabled: Bool (optional)
    ///   - fallbackFile: String (optional)
    ///   - installCommand: String (optional)
    ///   - installationId: String (optional)
    ///   - logging: Bool (optional)
    ///   - outputDirectory: String (optional)
    ///   - providerBranch: String (optional)
    ///   - providerRepositoryId: String (optional)
    ///   - providerRootDirectory: String (optional)
    ///   - providerSilentMode: Bool (optional)
    ///   - specification: String (optional)
    ///   - timeout: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Site
    ///
    open func sitesUpdate(
        siteId: String,
        framework: RevenexxEnums.Framework,
        name: String,
        adapter: RevenexxEnums.Adapter? = nil,
        buildCommand: String? = nil,
        buildRuntime: RevenexxEnums.BuildRuntime? = nil,
        enabled: Bool? = nil,
        fallbackFile: String? = nil,
        installCommand: String? = nil,
        installationId: String? = nil,
        logging: Bool? = nil,
        outputDirectory: String? = nil,
        providerBranch: String? = nil,
        providerRepositoryId: String? = nil,
        providerRootDirectory: String? = nil,
        providerSilentMode: Bool? = nil,
        specification: String? = nil,
        timeout: Int? = nil
    ) async throws -> RevenexxModels.Site {
        let apiPath: String = "/v1/sites/{siteId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "adapter": adapter,
            "buildCommand": buildCommand,
            "buildRuntime": buildRuntime,
            "enabled": enabled,
            "fallbackFile": fallbackFile,
            "framework": framework,
            "installCommand": installCommand,
            "installationId": installationId,
            "logging": logging,
            "name": name,
            "outputDirectory": outputDirectory,
            "providerBranch": providerBranch,
            "providerRepositoryId": providerRepositoryId,
            "providerRootDirectory": providerRootDirectory,
            "providerSilentMode": providerSilentMode,
            "specification": specification,
            "timeout": timeout
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Site = { response in
            return RevenexxModels.Site.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update the site active deployment. Use this endpoint to switch the code
    /// deployment that should be used when visitor opens your site.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Site
    ///
    open func sitesUpdateSiteDeployment(
        siteId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Site {
        let apiPath: String = "/v1/sites/{siteId}/deployment"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "deploymentId": deploymentId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Site = { response in
            return RevenexxModels.Site.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all the site's code deployments. You can use the query params
    /// to filter your results.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.DeploymentList
    ///
    open func sitesListDeployments(
        siteId: String,
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.DeploymentList {
        let apiPath: String = "/v1/sites/{siteId}/deployments"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.DeploymentList = { response in
            return RevenexxModels.DeploymentList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new site code deployment. Use this endpoint to upload a new
    /// version of your site code. To activate your newly uploaded code, you'll
    /// need to update the site's deployment to use your new deployment ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - activate: Bool
    ///   - code: InputFile
    ///   - buildCommand: String (optional)
    ///   - installCommand: String (optional)
    ///   - outputDirectory: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesCreateDeployment(
        siteId: String,
        activate: Bool,
        code: InputFile,
        buildCommand: String? = nil,
        installCommand: String? = nil,
        outputDirectory: String? = nil,
        onProgress: ((UploadProgress) -> Void)? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        var apiParams: [String: Any?] = [
            "activate": activate,
            "buildCommand": buildCommand,
            "code": code,
            "installCommand": installCommand,
            "outputDirectory": outputDirectory
        ]

        var apiHeaders: [String: String] = [
            "content-type": "multipart/form-data"
        ]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        let idParamName: String? = nil
        let paramName = "code"
        return try await client.chunkedUpload(
            path: apiPath,
            headers: &apiHeaders,
            params: &apiParams,
            paramName: paramName,
            idParamName: idParamName,
            converter: converter,
            onProgress: onProgress
        )
    }

    ///
    /// Create a new build for an existing site deployment. This endpoint allows
    /// you to rebuild a deployment with the updated site configuration, including
    /// its commands and output directory if they have been modified. The build
    /// process will be queued and executed asynchronously. The original
    /// deployment's code will be preserved and used for the new build.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesCreateDuplicateDeployment(
        siteId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments/duplicate"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "deploymentId": deploymentId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a deployment based on a template.
    /// 
    /// Unlike app templates, site templates have no listing on this API — that
    /// catalogue is the vendor's and is not reproduced here. Take `repository`,
    /// `owner`, `rootDirectory` and `reference` from wherever the template is
    /// published.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - owner: String
    ///   - reference: String
    ///   - repository: String
    ///   - rootDirectory: String
    ///   - type: RevenexxEnums.SitesCreateTemplateDeploymentType
    ///   - activate: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesCreateTemplateDeployment(
        siteId: String,
        owner: String,
        reference: String,
        repository: String,
        rootDirectory: String,
        type: RevenexxEnums.SitesCreateTemplateDeploymentType,
        activate: Bool? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments/template"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "activate": activate,
            "owner": owner,
            "reference": reference,
            "repository": repository,
            "rootDirectory": rootDirectory,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a deployment when a site is connected to VCS.
    /// 
    /// This endpoint lets you create deployment from a branch, commit, or a tag.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - reference: String
    ///   - type: RevenexxEnums.SitesCreateTemplateDeploymentType
    ///   - activate: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesCreateVcsDeployment(
        siteId: String,
        reference: String,
        type: RevenexxEnums.SitesCreateTemplateDeploymentType,
        activate: Bool? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments/vcs"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "activate": activate,
            "reference": reference,
            "type": type
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a site deployment by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func sitesDeleteDeployment(
        siteId: String,
        deploymentId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/sites/{siteId}/deployments/{deploymentId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{deploymentId}", with: deploymentId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a site deployment by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesGetDeployment(
        siteId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments/{deploymentId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{deploymentId}", with: deploymentId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a site deployment content by its unique ID. The endpoint response
    /// return with a 'Content-Disposition: attachment' header that tells the
    /// browser to start downloading the file to user downloads directory.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    ///   - type: RevenexxEnums.AppsGetDeploymentDownloadType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func sitesGetDeploymentDownload(
        siteId: String,
        deploymentId: String,
        type: RevenexxEnums.AppsGetDeploymentDownloadType? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/sites/{siteId}/deployments/{deploymentId}/download"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{deploymentId}", with: deploymentId)

        let apiParams: [String: Any?] = [
            "type": type
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Cancel an ongoing site deployment build. If the build is already in
    /// progress, it will be stopped and marked as canceled. If the build hasn't
    /// started yet, it will be marked as canceled without executing. You cannot
    /// cancel builds that have already completed (status 'ready') or failed. The
    /// response includes the final build status and details.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func sitesUpdateDeploymentStatus(
        siteId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/sites/{siteId}/deployments/{deploymentId}/status"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{deploymentId}", with: deploymentId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Deployment = { response in
            return RevenexxModels.Deployment.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PATCH",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all site logs. You can use the query params to filter your
    /// results.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ExecutionList
    ///
    open func sitesListLogs(
        siteId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.ExecutionList {
        let apiPath: String = "/v1/sites/{siteId}/logs"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "queries": queries,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.ExecutionList = { response in
            return RevenexxModels.ExecutionList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a site log by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - logId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func sitesDeleteLog(
        siteId: String,
        logId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/sites/{siteId}/logs/{logId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{logId}", with: logId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a site request log by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - logId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Execution
    ///
    open func sitesGetLog(
        siteId: String,
        logId: String
    ) async throws -> RevenexxModels.Execution {
        let apiPath: String = "/v1/sites/{siteId}/logs/{logId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{logId}", with: logId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Execution = { response in
            return RevenexxModels.Execution.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Get a list of all variables of a specific site.
    ///
    /// - Parameters:
    ///   - siteId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.VariableList
    ///
    open func sitesListVariables(
        siteId: String
    ) async throws -> RevenexxModels.VariableList {
        let apiPath: String = "/v1/sites/{siteId}/variables"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.VariableList = { response in
            return RevenexxModels.VariableList.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Create a new site variable. These variables can be accessed during build
    /// and runtime (server-side rendering) as environment variables.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - key: String
    ///   - value: String
    ///   - secret: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func sitesCreateVariable(
        siteId: String,
        key: String,
        value: String,
        secret: Bool? = nil
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/sites/{siteId}/variables"
            .replacingOccurrences(of: "{siteId}", with: siteId)

        let apiParams: [String: Any?] = [
            "key": key,
            "secret": secret,
            "value": value
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Variable = { response in
            return RevenexxModels.Variable.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Delete a variable by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - variableId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func sitesDeleteVariable(
        siteId: String,
        variableId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/sites/{siteId}/variables/{variableId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{variableId}", with: variableId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a variable by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - variableId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func sitesGetVariable(
        siteId: String,
        variableId: String
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/sites/{siteId}/variables/{variableId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{variableId}", with: variableId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Variable = { response in
            return RevenexxModels.Variable.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Update variable by its unique ID.
    ///
    /// - Parameters:
    ///   - siteId: String
    ///   - variableId: String
    ///   - key: String
    ///   - secret: Bool (optional)
    ///   - value: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func sitesUpdateVariable(
        siteId: String,
        variableId: String,
        key: String,
        secret: Bool? = nil,
        value: String? = nil
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/sites/{siteId}/variables/{variableId}"
            .replacingOccurrences(of: "{siteId}", with: siteId)
            .replacingOccurrences(of: "{variableId}", with: variableId)

        let apiParams: [String: Any?] = [
            "key": key,
            "secret": secret,
            "value": value
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Variable = { response in
            return RevenexxModels.Variable.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "PUT",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}