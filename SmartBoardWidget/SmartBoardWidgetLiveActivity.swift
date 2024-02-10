//
//  SmartBoardWidgetLiveActivity.swift
//  SmartBoardWidget
//
//  Created by 李毓琪 on 2024/2/11.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SmartBoardWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SmartBoardWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SmartBoardWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SmartBoardWidgetAttributes {
    fileprivate static var preview: SmartBoardWidgetAttributes {
        SmartBoardWidgetAttributes(name: "World")
    }
}

extension SmartBoardWidgetAttributes.ContentState {
    fileprivate static var smiley: SmartBoardWidgetAttributes.ContentState {
        SmartBoardWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SmartBoardWidgetAttributes.ContentState {
         SmartBoardWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SmartBoardWidgetAttributes.preview) {
   SmartBoardWidgetLiveActivity()
} contentStates: {
    SmartBoardWidgetAttributes.ContentState.smiley
    SmartBoardWidgetAttributes.ContentState.starEyes
}
