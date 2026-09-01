import AsyncHTTPClient
import Foundation
import NIO
import JSONCodable
import RevenexxEnums
import RevenexxModels

/// Outbound multi-channel messaging (email/SMS/push): templates, event bindings, sends (the sequencer service).
open class Messaging: Service {

    ///
    /// Filterable by `resource_type`, `resource_id` and `subject` — the last one
    /// being the human-readable name a row was recorded under (a template's key,
    /// a layout's name), which is what an operator has to hand six weeks later
    /// when the id means nothing to them.
    /// 
    /// There is no write route and no delete route: an append-only log with an
    /// editor is a log that says whatever the last editor wanted.
    ///
    /// - Parameters:
    ///   - resourceType: RevenexxEnums.ResourceType (optional)
    ///   - resourceId: String (optional)
    ///   - subject: String (optional)
    ///   - limit: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func auditIndex(
        resourceType: RevenexxEnums.ResourceType? = nil,
        resourceId: String? = nil,
        subject: String? = nil,
        limit: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/audit"

        let apiParams: [String: Any?] = [
            "resource_type": resourceType,
            "resource_id": resourceId,
            "subject": subject,
            "limit": limit
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// `?event_topic=` narrows to one topic, which is the question worth asking
    /// of this list: "what does this event actually do".
    ///
    /// - Parameters:
    ///   - eventTopic: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingIndex(
        eventTopic: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings"

        let apiParams: [String: Any?] = [
            "event_topic": eventTopic
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// `recipient` is a template, not an address: `{{ customer.email }}` is
    /// rendered against the event payload when the event arrives, which is the
    /// only way one binding can serve every customer. An event that renders it
    /// empty is skipped and logged rather than sent to nobody.
    /// 
    /// `locale` is what the OPERATOR said this route speaks, and it outranks the
    /// tenant's default. Leave it null when nobody has made that decision, so
    /// that the recipient's own language is still allowed to decide.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - eventTopic: String
    ///   - recipient: String
    ///   - templateKey: String
    ///   - enabled: Bool (optional)
    ///   - fallbackOrder: Int (optional)
    ///   - locale: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingStore(
        channel: String,
        eventTopic: String,
        recipient: String,
        templateKey: String,
        enabled: Bool? = nil,
        fallbackOrder: Int? = nil,
        locale: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "enabled": enabled,
            "event_topic": eventTopic,
            "fallback_order": fallbackOrder,
            "locale": locale,
            "recipient": recipient,
            "template_key": templateKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The event it answered goes back to doing nothing. Prefer `enabled: false`
    /// when the intent is to pause rather than to forget.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingDestroy(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// 404 for a binding belonging to another tenant, not 403 — an id that
    /// answered differently would say whether it exists.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingShow(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Every field is optional; only what is sent is written. `enabled: false`
    /// is how a binding is taken out of service without losing what it said —
    /// the alternative is deleting it and typing the payload path back in
    /// correctly from memory later.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - channel: String (optional)
    ///   - enabled: Bool (optional)
    ///   - eventTopic: String (optional)
    ///   - fallbackOrder: Int (optional)
    ///   - locale: String (optional)
    ///   - recipient: String (optional)
    ///   - templateKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingUpdatePatch(
        id: String,
        channel: String? = nil,
        enabled: Bool? = nil,
        eventTopic: String? = nil,
        fallbackOrder: Int? = nil,
        locale: String? = nil,
        recipient: String? = nil,
        templateKey: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel": channel,
            "enabled": enabled,
            "event_topic": eventTopic,
            "fallback_order": fallbackOrder,
            "locale": locale,
            "recipient": recipient,
            "template_key": templateKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Every field is optional; only what is sent is written. `enabled: false`
    /// is how a binding is taken out of service without losing what it said —
    /// the alternative is deleting it and typing the payload path back in
    /// correctly from memory later.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - channel: String (optional)
    ///   - enabled: Bool (optional)
    ///   - eventTopic: String (optional)
    ///   - fallbackOrder: Int (optional)
    ///   - locale: String (optional)
    ///   - recipient: String (optional)
    ///   - templateKey: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func bindingUpdate(
        id: String,
        channel: String? = nil,
        enabled: Bool? = nil,
        eventTopic: String? = nil,
        fallbackOrder: Int? = nil,
        locale: String? = nil,
        recipient: String? = nil,
        templateKey: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/bindings/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "channel": channel,
            "enabled": enabled,
            "event_topic": eventTopic,
            "fallback_order": fallbackOrder,
            "locale": locale,
            "recipient": recipient,
            "template_key": templateKey
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Answers per channel with: which fields the chosen provider wants and
    /// which of them are SET (never their values — secrets go in and do not come
    /// back), which markets hold an override, which providers this build offers,
    /// whether the deployment has the channel switched on at all, the URL to
    /// paste into the provider's own console so bounces and opens come back, and
    /// whether callbacks are actually arriving.
    /// 
    /// Admin tier on the read as well as the write: the identifiers alone —
    /// which Twilio account, which sender number — are more than a read-only
    /// operator has reason to see, and the webhook URL served here contains the
    /// tenant's callback token.
    ///
    /// - Parameters:
    ///   - market: String (optional)
    ///   - markets: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelCredentialIndex(
        market: String? = nil,
        markets: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channel-credentials"

        let apiParams: [String: Any?] = [
            "market": market,
            "markets": markets
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// With `?market=`, only that market's override goes and the global
    /// credentials stand — the market then sends over the global provider again,
    /// which is what it did before anybody configured it. Without a market the
    /// channel goes entirely, overrides and all: a caller asking for a channel
    /// to hold no credentials means all of them.
    /// 
    /// 204 whether or not anything was there. The caller wants this channel to
    /// hold no credentials, and it does.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - market: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelCredentialDestroy(
        channel: String,
        market: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channel-credentials/{channel}"
            .replacingOccurrences(of: "{channel}", with: channel)

        let apiParams: [String: Any?] = [
            "market": market
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// A PATCH in spirit whichever verb is used: only the fields present in the
    /// body are written, and the answer says which of them actually CHANGED, so
    /// a form that resent everything it had on screen does not report a change
    /// that did not happen.
    /// 
    /// Three refusals, all 422 and all deliberate rather than ignored. A field
    /// the channel's provider does not have (`unknown_credential_field`) — a
    /// typo sitting in the bag looking like configuration fails later with a
    /// message about a MISSING field the operator can see they filled in. A
    /// field the platform issues (`managed_credential`) — ignoring it would have
    /// the caller believe they set something. A channel with nothing to
    /// configure (`channel_not_configurable`), which is push: its VAPID keypair
    /// is generated at provisioning, and pasting a new one would orphan every
    /// browser registration the tenant has collected.
    /// 
    /// Switching provider is `driver`, and the fields in the same request are
    /// validated against the provider being switched TO — validating Postmark's
    /// key against Mailgun's field list is how a switch loses everything the
    /// operator just typed.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - market: String (optional)
    ///   - driver: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelCredentialUpdatePatch(
        channel: String,
        market: String? = nil,
        driver: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channel-credentials/{channel}"
            .replacingOccurrences(of: "{channel}", with: channel)

        let apiParams: [String: Any?] = [
            "market": market,
            "driver": driver
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// A PATCH in spirit whichever verb is used: only the fields present in the
    /// body are written, and the answer says which of them actually CHANGED, so
    /// a form that resent everything it had on screen does not report a change
    /// that did not happen.
    /// 
    /// Three refusals, all 422 and all deliberate rather than ignored. A field
    /// the channel's provider does not have (`unknown_credential_field`) — a
    /// typo sitting in the bag looking like configuration fails later with a
    /// message about a MISSING field the operator can see they filled in. A
    /// field the platform issues (`managed_credential`) — ignoring it would have
    /// the caller believe they set something. A channel with nothing to
    /// configure (`channel_not_configurable`), which is push: its VAPID keypair
    /// is generated at provisioning, and pasting a new one would orphan every
    /// browser registration the tenant has collected.
    /// 
    /// Switching provider is `driver`, and the fields in the same request are
    /// validated against the provider being switched TO — validating Postmark's
    /// key against Mailgun's field list is how a switch loses everything the
    /// operator just typed.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - market: String (optional)
    ///   - driver: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelCredentialUpdate(
        channel: String,
        market: String? = nil,
        driver: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channel-credentials/{channel}"
            .replacingOccurrences(of: "{channel}", with: channel)

        let apiParams: [String: Any?] = [
            "market": market,
            "driver": driver
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The one thing that turns this screen from a form into a tool. Credentials
    /// that only fail at send time cost a customer their first order
    /// confirmation, and by then nobody connects the failure to the afternoon
    /// somebody pasted a key with a trailing space.
    /// 
    /// **Always 200.** The answer is `{ok, message}` in the body, including when
    /// the credentials are wrong: the REQUEST was fine, the credentials are not,
    /// and a 4xx here would have the cockpit's own error handling swallow the
    /// one sentence worth reading. A channel that asks for no credentials at all
    /// (push, in-app) answers `ok: true` — "nothing to verify" is a finished
    /// check, not a failed one, and reporting it as an error painted a channel
    /// that has worked since provisioning in the same red as a wrong token.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - market: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelCredentialVerify(
        channel: String,
        market: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channel-credentials/{channel}/verify"
            .replacingOccurrences(of: "{channel}", with: channel)

        let apiParams: [String: Any?] = [
            "market": market
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Each entry says whether the channel is switched on and which provider
    /// carries it by default. A channel that is off will refuse a send, so a UI
    /// that offers a channel picker should build it from this rather than from a
    /// list of its own — a channel added to the service then appears without a
    /// release of the client.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func channelIndex(
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/channels"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// A tenant that was never provisioned has no row and still gets an answer:
    /// an empty shape rather than a 404, so the Cockpit's panels open on
    /// editable blanks instead of an error.
    /// 
    /// `meta.push_public_key` is the VAPID public key, and only the public one.
    /// A storefront cannot call `PushManager.subscribe()` without it, so it has
    /// to leave the service; the private half and every provider secret stay
    /// hidden on the model, where they are protected on every route rather than
    /// on this one.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func configShow(
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/config"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Reaches every message this tenant sends, including templates saved months
    /// ago — content placeholders resolve at send time, not at save time —
    /// which
    /// is why writing is admin tier while reading is not.
    /// 
    /// Two refusals worth knowing about. `defaults.brand` is 422, not ignored:
    /// the letterhead moved to /v1/layouts when a tenant gained more than one of
    /// them, and a letterhead edit that appears to save and changes nothing is
    /// the worst of the three possible behaviours. A half-written `quiet_hours`
    /// is 422 as well — a tenant that typed a start and forgot the end has an
    /// opinion about when not to message people, and silently sending through
    /// the night is the one answer that is definitely wrong.
    /// 
    /// Provider credentials cannot be written here. That path is
    /// /v1/channel-credentials, so the one route that handles secrets stays the
    /// one that was built for it.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - defaultLocale: String (optional)
    ///   - defaults: [String] (optional)
    ///   - product: String (optional)
    ///   - quietHours: [String] (optional)
    ///   - supportEmail: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func configUpdatePatch(
        defaultLocale: String? = nil,
        defaults: [String]? = nil,
        product: String? = nil,
        quietHours: [String]? = nil,
        supportEmail: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/config"

        let apiParams: [String: Any?] = [
            "default_locale": defaultLocale,
            "defaults": defaults,
            "product": product,
            "quiet_hours": quietHours,
            "support_email": supportEmail
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Reaches every message this tenant sends, including templates saved months
    /// ago — content placeholders resolve at send time, not at save time —
    /// which
    /// is why writing is admin tier while reading is not.
    /// 
    /// Two refusals worth knowing about. `defaults.brand` is 422, not ignored:
    /// the letterhead moved to /v1/layouts when a tenant gained more than one of
    /// them, and a letterhead edit that appears to save and changes nothing is
    /// the worst of the three possible behaviours. A half-written `quiet_hours`
    /// is 422 as well — a tenant that typed a start and forgot the end has an
    /// opinion about when not to message people, and silently sending through
    /// the night is the one answer that is definitely wrong.
    /// 
    /// Provider credentials cannot be written here. That path is
    /// /v1/channel-credentials, so the one route that handles secrets stays the
    /// one that was built for it.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - defaultLocale: String (optional)
    ///   - defaults: [String] (optional)
    ///   - product: String (optional)
    ///   - quietHours: [String] (optional)
    ///   - supportEmail: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func configUpdate(
        defaultLocale: String? = nil,
        defaults: [String]? = nil,
        product: String? = nil,
        quietHours: [String]? = nil,
        supportEmail: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/config"

        let apiParams: [String: Any?] = [
            "default_locale": defaultLocale,
            "defaults": defaults,
            "product": product,
            "quiet_hours": quietHours,
            "support_email": supportEmail
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The order is the list's purpose: it is a picker, and the entry most
    /// templates are actually on belongs at the top of it.
    /// 
    /// Market-scoped as a browsing filter — see the parameters. `GET
    /// /layouts/{id}`
    /// deliberately is not: somebody holding an id may read it.
    ///
    /// - Parameters:
    ///   - markets: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func layoutIndex(
        markets: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/layouts"

        let apiParams: [String: Any?] = [
            "markets": markets
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// A tenant's FIRST layout becomes the default whatever the request says: a
    /// tenant with no default cannot compile a template that does not name one.
    /// 
    /// The default may hold neither a validity window nor `enabled: false`, and
    /// asking for both in one request is refused with 422
    /// `layout_default_always_in_force`. There is no fallback behind the default
    /// — every template that names no layout is framed by it — so a window set
    /// today would take a tenant's whole letterhead away on a morning months
    /// from now, with nobody left who remembers typing the date.
    ///
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func layoutStore(
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/layouts"

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Answers 200 with a body rather than the 204 the other resources use: the
    /// count of reassigned templates is the part an operator needs, and a
    /// deletion that silently moved eleven templates onto another letterhead is
    /// one they would only discover from the next mail that went out.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func layoutDestroy(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/layouts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// Not market-filtered, deliberately: market scoping is a browsing concern,
    /// and somebody holding an id may read the row. A template pinned to a
    /// layout keeps mailing on it whatever market the reader is looking at.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func layoutShow(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/layouts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// The change reaches every template on this layout, including ones saved
    /// months ago and never opened since — which is exactly the change nobody
    /// remembers making when the mails start looking wrong. It is audited for
    /// that reason, and only when something actually changed: an audit line on
    /// every save teaches its readers to ignore the log.
    /// 
    /// Two 422s. Clearing `is_default` on the current default is
    /// `layout_default_required` — promoting another layout is the operation
    /// that exists for this, and it clears this one as a side effect, which is
    /// the only way the count stays at exactly one. Giving the default a
    /// validity window or switching it off is `layout_default_always_in_force`,
    /// and the check is made of the OUTCOME, so promoting a layout and dating it
    /// in the same request is caught.
    /// 
    /// The structural half of a layout — colours, width, font — is baked into
    /// each template's compiled body, so templates already on it keep the old
    /// one until they are recompiled.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func layoutUpdate(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/layouts/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// What the Cockpit's "start from a template" gallery is built from. These
    /// are not the tenant's rows and cannot be edited here: provisioning clones
    /// them into `/v1/templates`, and it is the clone that a tenant owns.
    ///
    /// - Parameters:
    ///   - channel: String (optional)
    ///   - locale: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func libraryIndex(
        channel: String? = nil,
        locale: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/library"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "locale": locale
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// `?channel=` and `?status=` narrow it; `?limit=` is clamped to 200 and
    /// defaults to 50. `?channel=inapp` is the tenant's in-app inbox — the
    /// Message row IS the inbox item, so there is no second store for it.
    /// 
    /// Rows are subject to the deployment's retention window and to erasure
    /// requests, so this is not an archive.
    ///
    /// - Parameters:
    ///   - channel: String (optional)
    ///   - status: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func messageIndex(
        channel: String? = nil,
        status: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/messages"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "status": status
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Carries the render model it was sent with, so "why did this mail say
    ///      * that" is answerable after the fact. That is also why the row is
    /// personal
    /// data and why it can be erased — see POST /v1/privacy/erasures.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func messageShow(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/messages/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Answers with the resolved subject, HTML and text exactly as a real send
    /// would produce them, so an editor can show a faithful preview without a
    /// message row, a provider call or a suppression check.
    /// 
    /// Takes no `market`, deliberately: rendering picks no provider, so there is
    /// nothing here for a market to change. Nor `send_at`, `draft` or
    /// `attachments` — all of them are properties of a dispatch, not of a
    /// render.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - template: String
    ///   - data: Any (optional)
    ///   - locale: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func sendPreview(
        channel: String,
        template: String,
        data: Any? = nil,
        locale: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/preview"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "data": data,
            "locale": locale,
            "template": template
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Per (channel, address), because an address is channel-shaped and the rows
    /// it has to line up with are keyed that way. Matching is done on the
    /// normalised form on both sides, so a request for `ada@acme.test` finds a
    /// log written for `Ada@Acme.test` — an erasure that misses on
    /// capitalisation is an erasure that did not happen and reports success.
    /// 
    /// Message rows and unsubscribe tokens are DELETED. Suppressions are KEPT
    /// with the clear-text address nulled: matching runs on a keyed hash, so the
    /// row can still block and can no longer identify. Deleting it instead is
    /// the obvious reading of "erase everything about them", and it is the
    /// reading that mails a dead address again next week — or mails somebody who
    /// complained, which is how a sending domain gets blocked.
    /// 
    /// Answers with the counts, `suppressions_kept` among them, so the design is
    /// stated in the response rather than only in this paragraph.
    ///
    /// - Parameters:
    ///   - address: String
    ///   - channel: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func erasureStore(
        address: String,
        channel: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/privacy/erasures"

        let apiParams: [String: Any?] = [
            "address": address,
            "channel": channel
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// By endpoint and not by id, because the browser knows its endpoint and has
    /// never seen our id — this is called from a service worker reacting to
    /// `pushsubscriptionchange`, or from a "turn off notifications" button.
    ///
    /// - Parameters:
    ///   - endpoint: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pushSubscriptionDestroy(
        endpoint: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/push/subscriptions"

        let apiParams: [String: Any?] = [
            "endpoint": endpoint
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// `subscriber_id` is required: this is not a list of everybody, and there
    /// is no route that is. The caller is a storefront acting for one visitor
    /// and has no business enumerating the rest.
    /// 
    /// The client key material is never returned — see the `$hidden` list on the
    /// model. A registration that can be read back is a registration somebody
    /// else can push with.
    ///
    /// - Parameters:
    ///   - subscriberId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pushSubscriptionIndex(
        subscriberId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/push/subscriptions"

        let apiParams: [String: Any?] = [
            "subscriber_id": subscriberId
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Send what `PushManager.subscribe()` handed back — the endpoint and the
    /// two keys — plus the id you know that person by. The VAPID public key the
    /// browser needs to produce it comes from `GET /v1/config`
    /// (`meta.push_public_key`).
    /// 
    /// **Idempotent by endpoint**, and the two statuses say which happened: 201
    /// for a browser seen for the first time, 200 for one already registered. A
    /// browser calls `subscribe()` on every page load and hands back the same
    /// endpoint each time; treating that as a new device would give one laptop a
    /// thousand rows and push to it a thousand times.
    ///
    /// - Parameters:
    ///   - endpoint: String
    ///   - keys: Any
    ///   - subscriberId: String
    ///   - userAgent: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func pushSubscriptionStore(
        endpoint: String,
        keys: Any,
        subscriberId: String,
        userAgent: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/push/subscriptions"

        let apiParams: [String: Any?] = [
            "endpoint": endpoint,
            "keys": keys,
            "subscriber_id": subscriberId,
            "user_agent": userAgent
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Renders a tenant template and dispatches it — now, at `send_at`, or at
    /// the end of the tenant's quiet hours.
    /// 
    /// The first line is deliberately a title, not a sentence about the
    /// mechanism: Scramble takes it as the operation's `summary`, and a summary
    /// is what an API explorer prints in its route list. The paragraph that used
    /// to be here ran to 119 characters across two lines, which the gateway's
    /// fragment tests reject for exactly that reason.
    /// 
    /// Retry-safe when the caller sends an `Idempotency-Key` header. The two
    /// answers are deliberately different:
    /// 
    ///   201 — a message was created by THIS call
    ///   200 — this key was already used; here is the message it produced
    /// 
    /// A caller has to be able to tell those apart. "Your mail went out" and
    /// "your mail had already gone out" are the same outcome and different
    /// facts, and a client reconciling its own records needs the second one.
    /// Same key with a different body is a 422 — see IdempotencyConflict.
    /// 
    /// A recipient on the tenant's suppression list is not sent to, and that is
    /// reported as a refusal rather than as a silent success.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - template: String
    ///   - to: String
    ///   - attachments: [Any] (optional)
    ///   - data: Any (optional)
    ///   - draft: Bool (optional)
    ///   - locale: String (optional)
    ///   - market: String (optional)
    ///   - sendAt: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func sendSend(
        channel: String,
        template: String,
        to: String,
        attachments: [Any]? = nil,
        data: Any? = nil,
        draft: Bool? = nil,
        locale: String? = nil,
        market: String? = nil,
        sendAt: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/send"

        let apiParams: [String: Any?] = [
            "attachments": attachments,
            "channel": channel,
            "data": data,
            "draft": draft,
            "locale": locale,
            "market": market,
            "send_at": sendAt,
            "template": template,
            "to": to
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Either `days` (a window ending now, default 30) or an explicit `from`/`to`
    /// span. Both ends of the span or neither: `from` alone would be an open
    /// range and the service would have to guess which end was meant.
    /// 
    /// Three numbers are deliberately not the naive ones, and the `window` block
    /// says so rather than leaving a chart to imply otherwise. The window is
    /// CLAMPED to the tenant's retention, and `clamped_by_retention` says when
    /// that happened — 90 days on a 30-day retention is 30 days of data wearing
    /// a 90-day label, and the trend line it draws invents a collapse that never
    /// happened. Opens are counted only over channels that can report them; SMS
    /// and push have no such thing, so dividing opens by all messages would
    /// quietly halve every open rate the moment a tenant adds a second channel.
    /// The delivery rate is sent ÷ (sent + failed): suppressed is the service
    /// doing what it was told, and counting it as a failure would punish a
    /// tenant for having a working unsubscribe list.
    /// 
    /// `previous` is the same window again immediately before this one, which is
    /// what turns a figure into a direction. **It is null** whenever the
    /// preceding window is not entirely inside retention: the query would answer
    /// zero rather than fail, and zero against 1,337 renders as a triumphant
    /// +100 % beside every tile on the screen. Show no trend rather than a
    /// flattering one.
    /// 
    /// Nothing here names a recipient. That is the delivery log, which is a
    /// different endpoint with a different question.
    ///
    /// - Parameters:
    ///   - days: Int (optional)
    ///   - from: String (optional)
    ///   - to: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func statsIndex(
        days: Int? = nil,
        from: String? = nil,
        to: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/stats"

        let apiParams: [String: Any?] = [
            "days": days,
            "from": from,
            "to": to
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Filterable by `channel`, `scope`, `reason` and `address`. The address
    /// filter is looked up by FINGERPRINT rather than against the address
    /// column, which is what makes "why did this person stop getting our mail"
    /// answerable for somebody who has since been erased: the row has no
    /// address left to match on, and the question is still the same question.
    ///
    /// - Parameters:
    ///   - channel: String (optional)
    ///   - scope: RevenexxEnums.Scope (optional)
    ///   - reason: RevenexxEnums.Reason (optional)
    ///   - address: String (optional)
    ///   - limit: Int (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func suppressionIndex(
        channel: String? = nil,
        scope: RevenexxEnums.Scope? = nil,
        reason: RevenexxEnums.Reason? = nil,
        address: String? = nil,
        limit: Int? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/suppressions"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "scope": scope,
            "reason": reason,
            "address": address,
            "limit": limit
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// 201 for a row this call created, 200 for an address that was already on
    /// the list — so a client can tell whether it changed anything.
    /// 
    /// The `scope` follows from the `reason` for every reason but `manual`, and
    /// asking for a different one is 422 `suppression_scope_fixed` rather than
    /// being quietly corrected: a caller who asked for `marketing` on a hard
    /// bounce has the model wrong, and a silent upgrade to `all` would leave
    /// them believing transactional mail still flows to an address that does not
    /// exist.
    ///
    /// - Parameters:
    ///   - address: String
    ///   - channel: String
    ///   - reason: RevenexxEnums.Reason
    ///   - expiresAt: String (optional)
    ///   - note: String (optional)
    ///   - scope: RevenexxEnums.Scope (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func suppressionStore(
        address: String,
        channel: String,
        reason: RevenexxEnums.Reason,
        expiresAt: String? = nil,
        note: String? = nil,
        scope: RevenexxEnums.Scope? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/suppressions"

        let apiParams: [String: Any?] = [
            "address": address,
            "channel": channel,
            "expires_at": expiresAt,
            "note": note,
            "reason": reason,
            "scope": scope
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Audited, unlike most deletes in this service. Removing a row here is the
    /// one operation that makes the service mail an address something decided
    /// not to mail — if a complaint turns into a spam report later, "who took
    ///      * this off the list, and when" is the whole investigation.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func suppressionDestroy(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/suppressions/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// `address` may be null: that is a person who has been erased
    /// (POST /v1/privacy/erasures). The row survives as a hash, which is the
    /// point — the clear text is gone and the address is still blocked.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func suppressionShow(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/suppressions/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// `?channel=` narrows to one channel. Market-scoped as a BROWSING filter:
    /// with `X-Revenexx-Market` the list is the global rows plus that market's,
    /// without it the global rows only, and `?markets=all` is the unscoped read.
    /// Never a boundary — the tenant is fixed by the credential and by row-level
    /// security, and no value of either parameter reaches another tenant's rows.
    ///
    /// - Parameters:
    ///   - channel: String (optional)
    ///   - markets: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateIndex(
        channel: String? = nil,
        markets: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates"

        let apiParams: [String: Any?] = [
            "channel": channel,
            "markets": markets
        ]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Send a `design` document and the service compiles it against the
    /// template's layout — or send `body_html` and `body_text` yourself and skip
    /// compilation entirely.
    /// 
    /// A design that the compiler refuses is 422 and NOTHING is written, with
    /// `error.details` naming the offending block. That order is deliberate: a
    /// save whose compile failed must leave the row alone, because storing the
    /// design while keeping a stale body would hand the next send a mail that no
    /// longer matches the document it claims to be built from, and nothing would
    /// ever surface it. A sidecar that is down is 503 `mjml_unavailable`, which
    /// is worth retrying; a rejected design is not.
    /// 
    /// The row this creates is a DRAFT and sends nothing until it is published.
    ///
    /// - Parameters:
    ///   - channel: String
    ///   - key: String
    ///   - bodyHtml: String (optional)
    ///   - bodyText: String (optional)
    ///   - contentSid: String (optional)
    ///   - design: [String] (optional)
    ///   - enabled: Bool (optional)
    ///   - layoutId: String (optional)
    ///   - locale: String (optional)
    ///   - markets: [String] (optional)
    ///   - messageClass: RevenexxEnums.MessageClass (optional)
    ///   - subject: String (optional)
    ///   - testMode: Bool (optional)
    ///   - title: String (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    ///   - variableDefaults: [String] (optional)
    ///   - variables: [String] (optional)
    ///   - whatsappCategory: RevenexxEnums.WhatsappCategory (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateStore(
        channel: String,
        key: String,
        bodyHtml: String? = nil,
        bodyText: String? = nil,
        contentSid: String? = nil,
        design: [String]? = nil,
        enabled: Bool? = nil,
        layoutId: String? = nil,
        locale: String? = nil,
        markets: [String]? = nil,
        messageClass: RevenexxEnums.MessageClass? = nil,
        subject: String? = nil,
        testMode: Bool? = nil,
        title: String? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil,
        variableDefaults: [String]? = nil,
        variables: [String]? = nil,
        whatsappCategory: RevenexxEnums.WhatsappCategory? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates"

        let apiParams: [String: Any?] = [
            "body_html": bodyHtml,
            "body_text": bodyText,
            "channel": channel,
            "content_sid": contentSid,
            "design": design,
            "enabled": enabled,
            "key": key,
            "layout_id": layoutId,
            "locale": locale,
            "markets": markets,
            "message_class": messageClass,
            "subject": subject,
            "test_mode": testMode,
            "title": title,
            "valid_from": validFrom,
            "valid_until": validUntil,
            "variable_defaults": variableDefaults,
            "variables": variables,
            "whatsapp_category": whatsappCategory
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Any binding still naming this template's key will find nothing when its
    /// event next arrives. Audited under the KEY as well as the id: after the
    /// delete the id resolves to nothing, and "deleted tmpl_01J…" is not
    /// something an operator can act on six weeks later.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateDestroy(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "DELETE",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }

    ///
    /// What customers are receiving is the published snapshot; see
    /// `GET /v1/templates/{id}/versions`, whose `meta.has_unpublished_changes`
    /// says whether the two differ.
    /// 
    /// Not market-filtered, deliberately: market scoping is a browsing concern
    /// and somebody holding an id may read the row.
    ///
    /// - Parameters:
    ///   - id: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateShow(
        id: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Only the fields sent are written, and the change is audited only when
    /// something actually changed — a PATCH that resent the same values records
    /// nothing, because an audit line on every save teaches its readers to
    /// ignore the log.
    /// 
    /// Moving a template to another layout recompiles it against the NEW one,
    /// even when nothing else changed: colours, width and font come from the
    /// layout and are already inlined, so a template that merely changed hands
    /// would otherwise keep showing the old letterhead until somebody happened
    /// to press save on it again.
    /// 
    /// Changes nothing customers receive until the template is published.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - bodyHtml: String (optional)
    ///   - bodyText: String (optional)
    ///   - contentSid: String (optional)
    ///   - design: [String] (optional)
    ///   - enabled: Bool (optional)
    ///   - layoutId: String (optional)
    ///   - markets: [String] (optional)
    ///   - messageClass: RevenexxEnums.MessageClass (optional)
    ///   - subject: String (optional)
    ///   - testMode: Bool (optional)
    ///   - title: String (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    ///   - variableDefaults: [String] (optional)
    ///   - variables: [String] (optional)
    ///   - whatsappCategory: RevenexxEnums.WhatsappCategory (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateUpdatePatch(
        id: String,
        bodyHtml: String? = nil,
        bodyText: String? = nil,
        contentSid: String? = nil,
        design: [String]? = nil,
        enabled: Bool? = nil,
        layoutId: String? = nil,
        markets: [String]? = nil,
        messageClass: RevenexxEnums.MessageClass? = nil,
        subject: String? = nil,
        testMode: Bool? = nil,
        title: String? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil,
        variableDefaults: [String]? = nil,
        variables: [String]? = nil,
        whatsappCategory: RevenexxEnums.WhatsappCategory? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "body_html": bodyHtml,
            "body_text": bodyText,
            "content_sid": contentSid,
            "design": design,
            "enabled": enabled,
            "layout_id": layoutId,
            "markets": markets,
            "message_class": messageClass,
            "subject": subject,
            "test_mode": testMode,
            "title": title,
            "valid_from": validFrom,
            "valid_until": validUntil,
            "variable_defaults": variableDefaults,
            "variables": variables,
            "whatsapp_category": whatsappCategory
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Only the fields sent are written, and the change is audited only when
    /// something actually changed — a PATCH that resent the same values records
    /// nothing, because an audit line on every save teaches its readers to
    /// ignore the log.
    /// 
    /// Moving a template to another layout recompiles it against the NEW one,
    /// even when nothing else changed: colours, width and font come from the
    /// layout and are already inlined, so a template that merely changed hands
    /// would otherwise keep showing the old letterhead until somebody happened
    /// to press save on it again.
    /// 
    /// Changes nothing customers receive until the template is published.
    /// 
    /// This path answers on `PUT` and `PATCH`, both routed to the same action.
    ///
    /// - Parameters:
    ///   - id: String
    ///   - bodyHtml: String (optional)
    ///   - bodyText: String (optional)
    ///   - contentSid: String (optional)
    ///   - design: [String] (optional)
    ///   - enabled: Bool (optional)
    ///   - layoutId: String (optional)
    ///   - markets: [String] (optional)
    ///   - messageClass: RevenexxEnums.MessageClass (optional)
    ///   - subject: String (optional)
    ///   - testMode: Bool (optional)
    ///   - title: String (optional)
    ///   - validFrom: String (optional)
    ///   - validUntil: String (optional)
    ///   - variableDefaults: [String] (optional)
    ///   - variables: [String] (optional)
    ///   - whatsappCategory: RevenexxEnums.WhatsappCategory (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateUpdate(
        id: String,
        bodyHtml: String? = nil,
        bodyText: String? = nil,
        contentSid: String? = nil,
        design: [String]? = nil,
        enabled: Bool? = nil,
        layoutId: String? = nil,
        markets: [String]? = nil,
        messageClass: RevenexxEnums.MessageClass? = nil,
        subject: String? = nil,
        testMode: Bool? = nil,
        title: String? = nil,
        validFrom: String? = nil,
        validUntil: String? = nil,
        variableDefaults: [String]? = nil,
        variables: [String]? = nil,
        whatsappCategory: RevenexxEnums.WhatsappCategory? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{id}"
            .replacingOccurrences(of: "{id}", with: id)

        let apiParams: [String: Any?] = [
            "body_html": bodyHtml,
            "body_text": bodyText,
            "content_sid": contentSid,
            "design": design,
            "enabled": enabled,
            "layout_id": layoutId,
            "markets": markets,
            "message_class": messageClass,
            "subject": subject,
            "test_mode": testMode,
            "title": title,
            "valid_from": validFrom,
            "valid_until": validUntil,
            "variable_defaults": variableDefaults,
            "variables": variables,
            "whatsapp_category": whatsappCategory
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Answers 200 with the version already live when there was nothing to
    /// publish, and 201 when a new one was written — so a client can tell
    /// whether its press did anything without diffing the payload.
    ///
    /// - Parameters:
    ///   - templateId: String
    ///   - note: String (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateVersionStore(
        templateId: String,
        note: String? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{templateId}/publish"
            .replacingOccurrences(of: "{templateId}", with: templateId)

        let apiParams: [String: Any?] = [
            "note": note
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Summaries only: version, subject, message class, layout, who published it
    /// and when, and their note. The BODIES are deliberately absent — a compiled
    /// `body_html` runs to tens of kilobytes, and a template with forty versions
    /// would make this a several-megabyte download that nobody scrolls to the
    /// end of. `GET /v1/templates/{id}/versions/{version}` serves the full
    /// snapshot for the one somebody actually opened.
    /// 
    /// `meta.published_version_id` says which of them is live — a property of
    /// the template, said once, rather than a flag repeated on every row that
    /// two rows could then claim. `meta.has_unpublished_changes` says whether
    /// the draft has moved on since.
    ///
    /// - Parameters:
    ///   - templateId: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateVersionIndex(
        templateId: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{templateId}/versions"
            .replacingOccurrences(of: "{templateId}", with: templateId)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// Addressed by its VERSION NUMBER — the small integer on the history row,
    /// not the snapshot's id — because that is the number an author has in front
    /// of them.
    /// 
    /// This is what sends actually rendered while that version was live, so it
    /// is the thing to read when the question is "what did the mail we sent in
    ///      * March say".
    ///
    /// - Parameters:
    ///   - templateId: String
    ///   - version: String
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateVersionShow(
        templateId: String,
        version: String
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{templateId}/versions/{version}"
            .replacingOccurrences(of: "{templateId}", with: templateId)
            .replacingOccurrences(of: "{version}", with: version)

        let apiParams: [String: Any] = [:]

        let apiHeaders: [String: String] = [:]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
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
    /// `publish: true` makes it live in the same transaction — see
    /// TemplatePublisher::restore for why that flag exists rather than asking
    /// the caller for a second round trip.
    ///
    /// - Parameters:
    ///   - templateId: String
    ///   - version: String
    ///   - publish: Bool (optional)
    /// - Throws: Exception if the request fails
    /// - Returns: RevenexxModels.Error
    ///
    open func templateVersionRestore(
        templateId: String,
        version: String,
        publish: Bool? = nil
    ) async throws -> RevenexxModels.Error {
        let apiPath: String = "/v1/messaging/templates/{templateId}/versions/{version}/restore"
            .replacingOccurrences(of: "{templateId}", with: templateId)
            .replacingOccurrences(of: "{version}", with: version)

        let apiParams: [String: Any?] = [
            "publish": publish
        ]

        let apiHeaders: [String: String] = [
            "content-type": "application/json"
        ]

        let converter: (Any) -> RevenexxModels.Error = { response in
            return RevenexxModels.Error.from(map: response as! [String: Any])
        }

        return try await client.call(
            method: "POST",
            path: apiPath,
            headers: apiHeaders,
            params: apiParams,
            converter: converter
        )
    }


}