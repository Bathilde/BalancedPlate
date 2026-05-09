//
//  BalancedPlateWidgetLiveActivity.swift
//  BalancedPlateWidget
//
//  Created by Bathilde Rocchia on 09/05/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BalancedPlateWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BalancedPlateWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BalancedPlateWidgetAttributes.self) { context in
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

extension BalancedPlateWidgetAttributes {
    fileprivate static var preview: BalancedPlateWidgetAttributes {
        BalancedPlateWidgetAttributes(name: "World")
    }
}

extension BalancedPlateWidgetAttributes.ContentState {
    fileprivate static var smiley: BalancedPlateWidgetAttributes.ContentState {
        BalancedPlateWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BalancedPlateWidgetAttributes.ContentState {
         BalancedPlateWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BalancedPlateWidgetAttributes.preview) {
   BalancedPlateWidgetLiveActivity()
} contentStates: {
    BalancedPlateWidgetAttributes.ContentState.smiley
    BalancedPlateWidgetAttributes.ContentState.starEyes
}
