//
//  UpdateWidgetTextIntent.swift
//  SmartBoard
//
//  Created by 李毓琪 on 2024/2/11.
//

import Foundation
import AppIntents
import WidgetKit

@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct UpdateWidgetTextIntent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "UpdateWidgetTextIntentIntent"

    static var title: LocalizedStringResource = "Update Widget Text Intent"
    static var description = IntentDescription("Updates the text displayed on the widget.")

    @Parameter(title: "Content", default: "None")
    var content: String?

    static var parameterSummary: some ParameterSummary {
        Summary("Place your new content: \(\.$content)") {
            \.$content
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$content)) { content in
            DisplayRepresentation(
                title: "Update content to \(content ?? "None")",
                subtitle: "Update the widget text"
            )
        }
    }

    func perform() async throws -> some IntentResult {
        guard let content = content else {
            throw UpdateWidgetTextError.noContentProvided
        }

        // Save the new content to UserDefaults accessible by the widget
        let defaults = UserDefaults(suiteName: "group.leeyaso.smartboard")
        defaults?.setValue(content, forKey: "widgetText")
        
        // Ask the widget to refresh
        WidgetCenter.shared.reloadAllTimelines()

        return .result()
    }
}

enum UpdateWidgetTextError: Error {
    case noContentProvided
}

