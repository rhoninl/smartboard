//
//  ContentView.swift
//  SmartBoard
//
//  Created by 李毓琪 on 2024/2/10.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("widgetText", store: UserDefaults(suiteName: "group.leeyaso.smartboard"))
    var widgetText: Double = 0.0

    var body: some View {
        VStack {
            TextField("Enter text for the widget", value: $widgetText, format: .number)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .onSubmit {
                WidgetCenter.shared.reloadAllTimelines()
            }
            .padding()
            Text("Current text: \(String(format: "%.2f", widgetText))")
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
