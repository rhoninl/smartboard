//
//  UpdateWidgetTextIntent.swift
//  SmartBoard
//
//  Created by 李毓琪 on 2024/2/14.
//

import Foundation
import AppIntents
import WidgetKit

@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct UpdateWidgetTextIntent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "UpdateWidgetTextIntentIntent"

    static var title: LocalizedStringResource = "Add Data to Varibale"
    static var description = IntentDescription("Add Data to displayed on the widget.")

    @Parameter(title: "Content")
    var parameter: Double?

    static var parameterSummary: some ParameterSummary {
        Summary("Please Input your detal data") {
            \.$parameter
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$parameter)) { parameter in
            DisplayRepresentation(
                title: "Please Input your detal data",
                subtitle: ""
            )
        }
    }

    func perform() async throws -> some IntentResult {
        print(parameter)
        guard let parameter = parameter else {
            throw UpdateWidgetTextError.noContentProvided
        }

        // Save the new content to UserDefaults accessible by the widget
        let defaults = UserDefaults(suiteName: "group.leeyaso.smartboard")
        guard let oldData = defaults?.value(forKey: "widgetText") as? Double else {
            throw UpdateWidgetTextError.badOldData
        }
        
        defaults?.setValue(oldData + parameter, forKey: "widgetText")
        
        // Ask the widget to refresh
        WidgetCenter.shared.reloadAllTimelines()

        return .result()
    }
}

enum UpdateWidgetTextError: Error {
    case noContentProvided
    case badOldData
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static var parameterParameterPrompt: Self {
        "Plase tell me the content"
    }
}

