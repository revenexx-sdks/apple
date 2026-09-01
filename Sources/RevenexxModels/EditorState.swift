import Foundation
import JSONCodable

/// Everything the blökkli editor runs on, for one page in one language, materialized at the current point of the undo history. The theme adapter maps it 1:1 onto blökkli's MappedState.
open class EditorState: Codable {

    enum CodingKeys: String, CodingKey {
        case currentUserIsOwner = "currentUserIsOwner"
        case droppableFieldValues = "droppableFieldValues"
        case editState = "editState"
        case features = "features"
        case fields = "fields"
        case ignoredAnalyzeIdentifiers = "ignoredAnalyzeIdentifiers"
        case langcode = "langcode"
        case mutatedEntity = "mutatedEntity"
        case mutatedHostOptions = "mutatedHostOptions"
        case mutatedOptions = "mutatedOptions"
        case mutations = "mutations"
        case page = "page"
        case textFieldValues = "textFieldValues"
        case translations = "translations"
        case violations = "violations"
    }

    /// Whether the caller may write. False means every write answers 409 until `POST …/take-ownership` — so the editor should go read-only rather than let someone type into a refusal.
    public let currentUserIsOwner: Bool?
    /// Every entity-reference field of every block — the fields an editor drags a product or a media item into.
    public let droppableFieldValues: [[String: AnyCodable]]?
    /// The open working copy, or `null` when nobody has started editing — in which case the state shown is simply the published one.
    public let editState: [String: AnyCodable]?
    /// What the tenant's settings allow, so a client hides a control instead of discovering the refusal.
    public let features: [String: AnyCodable]?
    /// The block tree, flattened into one entry per (host, field) pair. This is the list the editor renders and drops into.
    public let fields: [[String: AnyCodable]]?
    /// Analyze findings that were dismissed for this page, so the editor stops reporting them.
    public let ignoredAnalyzeIdentifiers: [String]?
    /// The language this whole state was resolved for — the `?langcode` that was applied, or the page's source language.
    public let langcode: String?
    /// The page-level field values the edit state changed, merged source-then-language — `{ "title": …, "slug": …, "meta": … }`. Empty when nobody edited the page itself, only its blocks.
    public let mutatedEntity: [String: AnyCodable]?
    /// The PAGE-level display options after the unpublished changes, as a flat `option key → value` map. Theme-defined.
    public let mutatedHostOptions: [String: AnyCodable]?
    /// Every block's display options after the unpublished changes, keyed by block uuid: `{ "<uuid>": { "background": "grey" } }`.
    public let mutatedOptions: [String: AnyCodable]?
    /// The undo/redo history, oldest first. Its length and `editState.currentIndex` are what an undo button and a history sidebar are drawn from.
    public let mutations: [[String: AnyCodable]]?
    /// The page itself, with the unpublished edits already applied — so the title here is what publishing would store, not what is stored now.
    public let page: [String: AnyCodable]?
    /// Every string field of every block, flattened. It is what the translation view and the CSV export are built on — one row per translatable string.
    public let textFieldValues: [[String: AnyCodable]]?
    /// Every language this page exists in, so the editor can offer a language switcher that shows what is missing.
    public let translations: [[String: AnyCodable]]?
    /// Why publishing would be refused right now. Empty means `POST …/publish` succeeds without `force`.
    public let violations: [[String: AnyCodable]]?

    init(
        currentUserIsOwner: Bool?,
        droppableFieldValues: [[String: AnyCodable]]?,
        editState: [String: AnyCodable]?,
        features: [String: AnyCodable]?,
        fields: [[String: AnyCodable]]?,
        ignoredAnalyzeIdentifiers: [String]?,
        langcode: String?,
        mutatedEntity: [String: AnyCodable]?,
        mutatedHostOptions: [String: AnyCodable]?,
        mutatedOptions: [String: AnyCodable]?,
        mutations: [[String: AnyCodable]]?,
        page: [String: AnyCodable]?,
        textFieldValues: [[String: AnyCodable]]?,
        translations: [[String: AnyCodable]]?,
        violations: [[String: AnyCodable]]?
    ) {
        self.currentUserIsOwner = currentUserIsOwner
        self.droppableFieldValues = droppableFieldValues
        self.editState = editState
        self.features = features
        self.fields = fields
        self.ignoredAnalyzeIdentifiers = ignoredAnalyzeIdentifiers
        self.langcode = langcode
        self.mutatedEntity = mutatedEntity
        self.mutatedHostOptions = mutatedHostOptions
        self.mutatedOptions = mutatedOptions
        self.mutations = mutations
        self.page = page
        self.textFieldValues = textFieldValues
        self.translations = translations
        self.violations = violations
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.currentUserIsOwner = try container.decodeIfPresent(Bool.self, forKey: .currentUserIsOwner)
        self.droppableFieldValues = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .droppableFieldValues)
        self.editState = try container.decodeIfPresent([String: AnyCodable].self, forKey: .editState)
        self.features = try container.decodeIfPresent([String: AnyCodable].self, forKey: .features)
        self.fields = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .fields)
        self.ignoredAnalyzeIdentifiers = try container.decodeIfPresent([String].self, forKey: .ignoredAnalyzeIdentifiers)
        self.langcode = try container.decodeIfPresent(String.self, forKey: .langcode)
        self.mutatedEntity = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedEntity)
        self.mutatedHostOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedHostOptions)
        self.mutatedOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedOptions)
        self.mutations = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .mutations)
        self.page = try container.decodeIfPresent([String: AnyCodable].self, forKey: .page)
        self.textFieldValues = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .textFieldValues)
        self.translations = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .translations)
        self.violations = try container.decodeIfPresent([[String: AnyCodable]].self, forKey: .violations)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currentUserIsOwner, forKey: .currentUserIsOwner)
        try container.encodeIfPresent(droppableFieldValues, forKey: .droppableFieldValues)
        try container.encodeIfPresent(editState, forKey: .editState)
        try container.encodeIfPresent(features, forKey: .features)
        try container.encodeIfPresent(fields, forKey: .fields)
        try container.encodeIfPresent(ignoredAnalyzeIdentifiers, forKey: .ignoredAnalyzeIdentifiers)
        try container.encodeIfPresent(langcode, forKey: .langcode)
        try container.encodeIfPresent(mutatedEntity, forKey: .mutatedEntity)
        try container.encodeIfPresent(mutatedHostOptions, forKey: .mutatedHostOptions)
        try container.encodeIfPresent(mutatedOptions, forKey: .mutatedOptions)
        try container.encodeIfPresent(mutations, forKey: .mutations)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(textFieldValues, forKey: .textFieldValues)
        try container.encodeIfPresent(translations, forKey: .translations)
        try container.encodeIfPresent(violations, forKey: .violations)
    }

    public func toMap() -> [String: Any] {
        return [
            "currentUserIsOwner": currentUserIsOwner as Any,
            "droppableFieldValues": droppableFieldValues as Any,
            "editState": editState as Any,
            "features": features as Any,
            "fields": fields as Any,
            "ignoredAnalyzeIdentifiers": ignoredAnalyzeIdentifiers as Any,
            "langcode": langcode as Any,
            "mutatedEntity": mutatedEntity as Any,
            "mutatedHostOptions": mutatedHostOptions as Any,
            "mutatedOptions": mutatedOptions as Any,
            "mutations": mutations as Any,
            "page": page as Any,
            "textFieldValues": textFieldValues as Any,
            "translations": translations as Any,
            "violations": violations as Any
        ]
    }

    public static func from(map: [String: Any] ) -> EditorState {
        return EditorState(
            currentUserIsOwner: map["currentUserIsOwner"] as? Bool,
            droppableFieldValues: map["droppableFieldValues"] as? [[String: AnyCodable]],
            editState: map["editState"] as? [String: AnyCodable],
            features: map["features"] as? [String: AnyCodable],
            fields: map["fields"] as? [[String: AnyCodable]],
            ignoredAnalyzeIdentifiers: map["ignoredAnalyzeIdentifiers"] as? [String],
            langcode: map["langcode"] as? String,
            mutatedEntity: map["mutatedEntity"] as? [String: AnyCodable],
            mutatedHostOptions: map["mutatedHostOptions"] as? [String: AnyCodable],
            mutatedOptions: map["mutatedOptions"] as? [String: AnyCodable],
            mutations: map["mutations"] as? [[String: AnyCodable]],
            page: map["page"] as? [String: AnyCodable],
            textFieldValues: map["textFieldValues"] as? [[String: AnyCodable]],
            translations: map["translations"] as? [[String: AnyCodable]],
            violations: map["violations"] as? [[String: AnyCodable]]
        )
    }
}
