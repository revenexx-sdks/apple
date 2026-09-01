import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// The Revenexx app runtime (Appwrite functions, extended) and marketplace.
open class Apps: Service {

    ///
    /// List all Apps in the active project. Pass `search` to filter by name.
    ///
    /// - Parameters:
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.FunctionList
    ///
    open func appsList(
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.FunctionList {
        let apiPath: String = "/v1/apps"

        let apiParams: [String: Any?] = [
            "queries": queries,
            "search": search,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.FunctionList = { response in
            return RevenexxModels.FunctionList.from(map: response as! [String: Any])
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
    /// Create a new revenexx App. An App is the deployment surface for code that
    /// runs on the platform — backend jobs, APIs, integrations. The created App
    /// owns subsequent deployments and executions.
    /// 
    /// Phase 1 mirrors the underlying Functions runtime 1:1; future phases will
    /// add manifest validation, registry coupling and schema migrations.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - name: String
    ///   - runtime: RevenexxEnums.Runtime
    ///   - commands: String (optional)
    ///   - enabled: Bool (optional)
    ///   - entrypoint: String (optional)
    ///   - events: [String] (optional)
    ///   - execute: [String] (optional)
    ///   - installationId: String (optional)
    ///   - logging: Bool (optional)
    ///   - providerBranch: String (optional)
    ///   - providerRepositoryId: String (optional)
    ///   - providerRootDirectory: String (optional)
    ///   - providerSilentMode: Bool (optional)
    ///   - schedule: String (optional)
    ///   - scopes: [RevenexxEnums.Scopes] (optional)
    ///   - specification: String (optional)
    ///   - timeout: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Function
    ///
    open func appsCreate(
        functionId: String,
        name: String,
        runtime: RevenexxEnums.Runtime,
        commands: String? = nil,
        enabled: Bool? = nil,
        entrypoint: String? = nil,
        events: [String]? = nil,
        execute: [String]? = nil,
        installationId: String? = nil,
        logging: Bool? = nil,
        providerBranch: String? = nil,
        providerRepositoryId: String? = nil,
        providerRootDirectory: String? = nil,
        providerSilentMode: Bool? = nil,
        schedule: String? = nil,
        scopes: [RevenexxEnums.Scopes]? = nil,
        specification: String? = nil,
        timeout: Int? = nil
    ) async throws -> RevenexxModels.Function {
        let apiPath: String = "/v1/apps"

        let apiParams: [String: Any?] = [
            "commands": commands,
            "enabled": enabled,
            "entrypoint": entrypoint,
            "events": events,
            "execute": execute,
            "functionId": functionId,
            "installationId": installationId,
            "logging": logging,
            "name": name,
            "providerBranch": providerBranch,
            "providerRepositoryId": providerRepositoryId,
            "providerRootDirectory": providerRootDirectory,
            "providerSilentMode": providerSilentMode,
            "runtime": runtime,
            "schedule": schedule,
            "scopes": scopes,
            "specification": specification,
            "timeout": timeout
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Function = { response in
            return RevenexxModels.Function.from(map: response as! [String: Any])
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
    /// List apps published to the Marketplace. Proxies the App Registry on Console
    /// with `?published=true` filter.
    ///
    /// - Parameters:
    ///   - search: String (optional)
    ///   - perPage: Int (optional)
    ///   - page: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsListMarketplace(
        search: String? = nil,
        perPage: Int? = nil,
        page: Int? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/marketplace"

        let apiParams: [String: Any?] = [
            "search": search,
            "per_page": perPage,
            "page": page
        ]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Install a Marketplace app on the calling project's tenant. Body: { owner,
    /// name }.
    ///
    /// - Parameters:
    ///   - name: String
    ///   - owner: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsInstallFromMarketplace(
        name: String,
        owner: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/marketplace/install"

        let apiParams: [String: Any?] = [
            "name": name,
            "owner": owner
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get a list of all runtimes available for an App. Identical content to
    /// `functions.listRuntimes()`.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.RuntimeList
    ///
    open func appsListRuntimes(
    ) async throws -> RevenexxModels.RuntimeList {
        let apiPath: String = "/v1/apps/runtimes"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.RuntimeList = { response in
            return RevenexxModels.RuntimeList.from(map: response as! [String: Any])
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
    /// List the compute specifications (CPU + memory) available to Apps in this
    /// project.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.SpecificationList
    ///
    open func appsListSpecifications(
    ) async throws -> RevenexxModels.SpecificationList {
        let apiPath: String = "/v1/apps/specifications"

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
    /// List the curated catalogue of App templates that can be used as starting
    /// points.
    ///
    /// - Parameters:
    ///   - runtimes: [RevenexxEnums.Runtimes] (optional)
    ///   - useCases: [RevenexxEnums.UseCases] (optional)
    ///   - limit: Int (optional)
    ///   - offset: Int (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.TemplateFunctionList
    ///
    open func appsListTemplates(
        runtimes: [RevenexxEnums.Runtimes]? = nil,
        useCases: [RevenexxEnums.UseCases]? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.TemplateFunctionList {
        let apiPath: String = "/v1/apps/templates"

        let apiParams: [String: Any?] = [
            "runtimes": runtimes,
            "useCases": useCases,
            "limit": limit,
            "offset": offset,
            "total": total
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.TemplateFunctionList = { response in
            return RevenexxModels.TemplateFunctionList.from(map: response as! [String: Any])
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
    /// Get a single App template by its ID.
    ///
    /// - Parameters:
    ///   - templateId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.TemplateFunction
    ///
    open func appsGetTemplate(
        templateId: String
    ) async throws -> RevenexxModels.TemplateFunction {
        let apiPath: String = "/v1/apps/templates/{templateId}"
            .replacingOccurrences(of: "{templateId}", with: templateId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.TemplateFunction = { response in
            return RevenexxModels.TemplateFunction.from(map: response as! [String: Any])
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
    /// Get aggregated usage stats across all Apps in the project for the requested
    /// time range.
    ///
    /// - Parameters:
    ///   - range: RevenexxEnums.Range (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.UsageFunctions
    ///
    open func appsListUsage(
        range: RevenexxEnums.Range? = nil
    ) async throws -> RevenexxModels.UsageFunctions {
        let apiPath: String = "/v1/apps/usage"

        let apiParams: [String: Any?] = [
            "range": range
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.UsageFunctions = { response in
            return RevenexxModels.UsageFunctions.from(map: response as! [String: Any])
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
    /// Delete an App and all of its deployments. Cascades to the App Registry —
    /// Console removes the matching `RegisteredApp` row.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsDelete(
        functionId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get an App by its unique ID.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Function
    ///
    open func appsGet(
        functionId: String
    ) async throws -> RevenexxModels.Function {
        let apiPath: String = "/v1/apps/{functionId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Function = { response in
            return RevenexxModels.Function.from(map: response as! [String: Any])
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
    /// Update an App. Use this endpoint to rename, change runtime, schedule,
    /// environment variables and other configuration.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - name: String
    ///   - commands: String (optional)
    ///   - enabled: Bool (optional)
    ///   - entrypoint: String (optional)
    ///   - events: [String] (optional)
    ///   - execute: [String] (optional)
    ///   - installationId: String (optional)
    ///   - logging: Bool (optional)
    ///   - providerBranch: String (optional)
    ///   - providerRepositoryId: String (optional)
    ///   - providerRootDirectory: String (optional)
    ///   - providerSilentMode: Bool (optional)
    ///   - runtime: RevenexxEnums.Runtime (optional)
    ///   - schedule: String (optional)
    ///   - scopes: [RevenexxEnums.Scopes] (optional)
    ///   - specification: String (optional)
    ///   - timeout: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Function
    ///
    open func appsUpdate(
        functionId: String,
        name: String,
        commands: String? = nil,
        enabled: Bool? = nil,
        entrypoint: String? = nil,
        events: [String]? = nil,
        execute: [String]? = nil,
        installationId: String? = nil,
        logging: Bool? = nil,
        providerBranch: String? = nil,
        providerRepositoryId: String? = nil,
        providerRootDirectory: String? = nil,
        providerSilentMode: Bool? = nil,
        runtime: RevenexxEnums.Runtime? = nil,
        schedule: String? = nil,
        scopes: [RevenexxEnums.Scopes]? = nil,
        specification: String? = nil,
        timeout: Int? = nil
    ) async throws -> RevenexxModels.Function {
        let apiPath: String = "/v1/apps/{functionId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any?] = [
            "commands": commands,
            "enabled": enabled,
            "entrypoint": entrypoint,
            "events": events,
            "execute": execute,
            "installationId": installationId,
            "logging": logging,
            "name": name,
            "providerBranch": providerBranch,
            "providerRepositoryId": providerRepositoryId,
            "providerRootDirectory": providerRootDirectory,
            "providerSilentMode": providerSilentMode,
            "runtime": runtime,
            "schedule": schedule,
            "scopes": scopes,
            "specification": specification,
            "timeout": timeout
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Function = { response in
            return RevenexxModels.Function.from(map: response as! [String: Any])
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
    /// Set the active deployment for an App. The chosen deployment must already be
    /// `ready`.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Function
    ///
    open func appsUpdateDeployment(
        functionId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Function {
        let apiPath: String = "/v1/apps/{functionId}/deployment"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any?] = [
            "deploymentId": deploymentId
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Function = { response in
            return RevenexxModels.Function.from(map: response as! [String: Any])
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
    /// List the deployment history of an App.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - queries: [String] (optional)
    ///   - search: String (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.DeploymentList
    ///
    open func appsListDeployments(
        functionId: String,
        queries: [String]? = nil,
        search: String? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.DeploymentList {
        let apiPath: String = "/v1/apps/{functionId}/deployments"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Upload a new code deployment for an App. Accepts a `.tar.gz`
    /// archive containing the App source. Phase 2 will extract the
    /// manifest from this archive and validate it against the App
    /// Registry before kicking off the build.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - activate: Bool
    ///   - code: InputFile
    ///   - commands: String (optional)
    ///   - entrypoint: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsCreateDeployment(
        functionId: String,
        activate: Bool,
        code: InputFile,
        commands: String? = nil,
        entrypoint: String? = nil,
        onProgress: ((UploadProgress) -> Void)? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        var apiParams: [String: Any?] = [
            "activate": activate,
            "code": code,
            "commands": commands,
            "entrypoint": entrypoint
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
    /// Re-deploy an existing build under a new deployment ID. Useful for promoting
    /// a known-good preview build to production without rebuilding.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    ///   - buildId: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsCreateDuplicateDeployment(
        functionId: String,
        deploymentId: String,
        buildId: String? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments/duplicate"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any?] = [
            "buildId": buildId,
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
    /// Create a new App deployment from a template in the App Templates catalogue.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - owner: String
    ///   - reference: String
    ///   - repository: String
    ///   - rootDirectory: String
    ///   - type: RevenexxEnums.`Type`
    ///   - activate: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsCreateTemplateDeployment(
        functionId: String,
        owner: String,
        reference: String,
        repository: String,
        rootDirectory: String,
        type: RevenexxEnums.`Type`,
        activate: Bool? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments/template"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Trigger a new deployment from the App's connected Git repository.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - reference: String
    ///   - type: RevenexxEnums.AppsCreateVcsDeploymentType
    ///   - activate: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsCreateVcsDeployment(
        functionId: String,
        reference: String,
        type: RevenexxEnums.AppsCreateVcsDeploymentType,
        activate: Bool? = nil
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments/vcs"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Delete a deployment. The active deployment cannot be deleted while it is
    /// active — switch first via the deployment-update endpoint.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsDeleteDeployment(
        functionId: String,
        deploymentId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/deployments/{deploymentId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// Get a deployment by its unique ID.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsGetDeployment(
        functionId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments/{deploymentId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// Get a redirect URL to download the source archive of an App deployment.
    /// Useful for re-running a build locally or auditing what was deployed.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    ///   - type: RevenexxEnums.AppsGetDeploymentDownloadType (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsGetDeploymentDownload(
        functionId: String,
        deploymentId: String,
        type: RevenexxEnums.AppsGetDeploymentDownloadType? = nil
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/deployments/{deploymentId}/download"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// Cancel an in-progress deployment build. Used by the Cockpit "Cancel build"
    /// affordance.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - deploymentId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Deployment
    ///
    open func appsUpdateDeploymentStatus(
        functionId: String,
        deploymentId: String
    ) async throws -> RevenexxModels.Deployment {
        let apiPath: String = "/v1/apps/{functionId}/deployments/{deploymentId}/status"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// List the execution history of an App.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - queries: [String] (optional)
    ///   - total: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.ExecutionList
    ///
    open func appsListExecutions(
        functionId: String,
        queries: [String]? = nil,
        total: Bool? = nil
    ) async throws -> RevenexxModels.ExecutionList {
        let apiPath: String = "/v1/apps/{functionId}/executions"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Trigger an App execution. Use the optional `body`, `path`, `method` and
    /// `headers` parameters to invoke the App as if from an HTTP request.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - async: Bool (optional)
    ///   - body: String (optional)
    ///   - headers: Any (optional)
    ///   - method: RevenexxEnums.Method (optional)
    ///   - path: String (optional)
    ///   - scheduledAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Execution
    ///
    open func appsCreateExecution(
        functionId: String,
        async: Bool? = nil,
        body: String? = nil,
        headers: Any? = nil,
        method: RevenexxEnums.Method? = nil,
        path: String? = nil,
        scheduledAt: String? = nil
    ) async throws -> RevenexxModels.Execution {
        let apiPath: String = "/v1/apps/{functionId}/executions"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any?] = [
            "async": async,
            "body": body,
            "headers": headers,
            "method": method,
            "path": path,
            "scheduledAt": scheduledAt
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Execution = { response in
            return RevenexxModels.Execution.from(map: response as! [String: Any])
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
    /// Delete an App execution by its unique ID.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - executionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsDeleteExecution(
        functionId: String,
        executionId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/executions/{executionId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
            .replacingOccurrences(of: "{executionId}", with: executionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get an App execution by its unique ID.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - executionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Execution
    ///
    open func appsGetExecution(
        functionId: String,
        executionId: String
    ) async throws -> RevenexxModels.Execution {
        let apiPath: String = "/v1/apps/{functionId}/executions/{executionId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
            .replacingOccurrences(of: "{executionId}", with: executionId)

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
    /// Read-through view of the App's App Registry row — visibility +
    /// Marketplace publish flag. Used by Cockpit to render the Publish/Unpublish
    /// button correctly on cold load.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsGetMarketplaceStatus(
        functionId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/marketplace-status"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "GET",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Remove this App from the Marketplace listing. Existing tenant installations
    /// are unaffected. Idempotent.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsUnpublish(
        functionId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/publish"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Publish this App to the Marketplace. The App must have at
    /// least one `ready` deployment with a registered manifest,
    /// and its visibility (derived from `billing.json`) must be
    /// `public` or `included`. Idempotent.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsPublish(
        functionId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/publish"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams        )
    }

    ///
    /// Get usage stats for a single App over the requested time range.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - range: RevenexxEnums.Range (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.UsageFunction
    ///
    open func appsGetUsage(
        functionId: String,
        range: RevenexxEnums.Range? = nil
    ) async throws -> RevenexxModels.UsageFunction {
        let apiPath: String = "/v1/apps/{functionId}/usage"
            .replacingOccurrences(of: "{functionId}", with: functionId)

        let apiParams: [String: Any?] = [
            "range": range
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.UsageFunction = { response in
            return RevenexxModels.UsageFunction.from(map: response as! [String: Any])
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
    /// List all environment variables defined for the App.
    ///
    /// - Parameters:
    ///   - functionId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.VariableList
    ///
    open func appsListVariables(
        functionId: String
    ) async throws -> RevenexxModels.VariableList {
        let apiPath: String = "/v1/apps/{functionId}/variables"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Create a new App environment variable. These are passed into the App at
    /// runtime as `process.env.*`.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - key: String
    ///   - value: String
    ///   - secret: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func appsCreateVariable(
        functionId: String,
        key: String,
        value: String,
        secret: Bool? = nil
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/apps/{functionId}/variables"
            .replacingOccurrences(of: "{functionId}", with: functionId)

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
    /// Delete an App environment variable.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - variableId: String
    /// - Throws: Exception if the request fails
    /// - Returns: Any
    ///
    open func appsDeleteVariable(
        functionId: String,
        variableId: String
    ) async throws -> Any {
        let apiPath: String = "/v1/apps/{functionId}/variables/{variableId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// Get an App variable by its unique ID.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - variableId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func appsGetVariable(
        functionId: String,
        variableId: String
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/apps/{functionId}/variables/{variableId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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
    /// Update an App environment variable.
    ///
    /// - Parameters:
    ///   - functionId: String
    ///   - variableId: String
    ///   - key: String
    ///   - secret: Bool (optional)
    ///   - value: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Variable
    ///
    open func appsUpdateVariable(
        functionId: String,
        variableId: String,
        key: String,
        secret: Bool? = nil,
        value: String? = nil
    ) async throws -> RevenexxModels.Variable {
        let apiPath: String = "/v1/apps/{functionId}/variables/{variableId}"
            .replacingOccurrences(of: "{functionId}", with: functionId)
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