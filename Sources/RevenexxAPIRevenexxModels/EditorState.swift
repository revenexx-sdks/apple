import Foundation
import JSONCodable

/// The blökkli adapter state: page, translations, edit state + mutation log, materialized field lists, mutated options/entity values, text field values, droppable field values and violations.
open class EditorState: Codable {

    enum CodingKeys: String, CodingKey {
        case currentUserIsOwner = "currentUserIsOwner"
        case droppableFieldValues = "droppableFieldValues"
        case editState = "editState"
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

    /// 
    public let currentUserIsOwner: Bool?
    /// 
    public let droppableFieldValues: [Any]?
    /// 
    public let editState: [String: AnyCodable]?
    /// 
    public let fields: [Any]?
    /// 
    public let ignoredAnalyzeIdentifiers: [String]?
    /// 
    public let langcode: String?
    /// 
    public let mutatedEntity: [String: AnyCodable]?
    /// 
    public let mutatedHostOptions: [String: AnyCodable]?
    /// 
    public let mutatedOptions: [String: AnyCodable]?
    /// 
    public let mutations: [Any]?
    /// 
    public let page: [String: AnyCodable]?
    /// 
    public let textFieldValues: [Any]?
    /// 
    public let translations: [Any]?
    /// 
    public let violations: [Any]?

    init(
        currentUserIsOwner: Bool?,
        droppableFieldValues: [Any]?,
        editState: [String: AnyCodable]?,
        fields: [Any]?,
        ignoredAnalyzeIdentifiers: [String]?,
        langcode: String?,
        mutatedEntity: [String: AnyCodable]?,
        mutatedHostOptions: [String: AnyCodable]?,
        mutatedOptions: [String: AnyCodable]?,
        mutations: [Any]?,
        page: [String: AnyCodable]?,
        textFieldValues: [Any]?,
        translations: [Any]?,
        violations: [Any]?
    ) {
        self.currentUserIsOwner = currentUserIsOwner
        self.droppableFieldValues = droppableFieldValues
        self.editState = editState
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
        self.droppableFieldValues = try container.decodeIfPresent([Any].self, forKey: .droppableFieldValues)
        self.editState = try container.decodeIfPresent([String: AnyCodable].self, forKey: .editState)
        self.fields = try container.decodeIfPresent([Any].self, forKey: .fields)
        self.ignoredAnalyzeIdentifiers = try container.decodeIfPresent([String].self, forKey: .ignoredAnalyzeIdentifiers)
        self.langcode = try container.decodeIfPresent(String.self, forKey: .langcode)
        self.mutatedEntity = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedEntity)
        self.mutatedHostOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedHostOptions)
        self.mutatedOptions = try container.decodeIfPresent([String: AnyCodable].self, forKey: .mutatedOptions)
        self.mutations = try container.decodeIfPresent([Any].self, forKey: .mutations)
        self.page = try container.decodeIfPresent([String: AnyCodable].self, forKey: .page)
        self.textFieldValues = try container.decodeIfPresent([Any].self, forKey: .textFieldValues)
        self.translations = try container.decodeIfPresent([Any].self, forKey: .translations)
        self.violations = try container.decodeIfPresent([Any].self, forKey: .violations)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(currentUserIsOwner, forKey: .currentUserIsOwner)
        try container.encodeIfPresent(droppableFieldValues, forKey: .droppableFieldValues)
        try container.encodeIfPresent(editState, forKey: .editState)
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
            droppableFieldValues: map["droppableFieldValues"] as? [Any],
            editState: map["editState"] as? [String: AnyCodable],
            fields: map["fields"] as? [Any],
            ignoredAnalyzeIdentifiers: map["ignoredAnalyzeIdentifiers"] as? [String],
            langcode: map["langcode"] as? String,
            mutatedEntity: map["mutatedEntity"] as? [String: AnyCodable],
            mutatedHostOptions: map["mutatedHostOptions"] as? [String: AnyCodable],
            mutatedOptions: map["mutatedOptions"] as? [String: AnyCodable],
            mutations: map["mutations"] as? [Any],
            page: map["page"] as? [String: AnyCodable],
            textFieldValues: map["textFieldValues"] as? [Any],
            translations: map["translations"] as? [Any],
            violations: map["violations"] as? [Any]
        )
    }
}
