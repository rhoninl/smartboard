//
//  SmartBoardWidget.swift
//  SmartBoardWidget
//
//  Created by 李毓琪 on 2024/2/11.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), str: "test")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, str: "data")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration,str: getData())
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    private func getData() -> String {
        guard let widgetText = UserDefaults(suiteName: "group.leeyaso.smartboard") else {
                return "empty"
        }
        
        let data = widgetText.value(forKey: "widgetText")
        
        return "\(data ?? "none")"
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let str: String
}

struct SmartBoardWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack{
                Text(entry.configuration.favoriteEmoji)
                Spacer()
                    .frame(width: 75)
            }
            Text(entry.str != "" ? "¥" + entry.str : "empty")
                .font(.title)
        }
    }
}

struct SmartBoardWidget: Widget {
    let kind: String = "SmartBoardWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            SmartBoardWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    SmartBoardWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, str: "test")
    SimpleEntry(date: .now, configuration: .starEyes, str: "test1")
}
