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
    var widgetText: String = ""

    var body: some View {
        VStack {
            TextField("Enter text for the widget", text: $widgetText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                .padding()
            Text("Current text: \(widgetText)")
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
