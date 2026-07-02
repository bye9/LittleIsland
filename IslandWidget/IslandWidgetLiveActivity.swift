//
//  IslandWidgetLiveActivity.swift
//  IslandWidget
//
//  Created by JeongHwan Seok on 7/2/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct IslandWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var pose: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct IslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: IslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.pose)")
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
                    Text("Bottom \(context.state.pose)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.pose)")
            } minimal: {
                Text(context.state.pose)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension IslandWidgetAttributes {
    fileprivate static var preview: IslandWidgetAttributes {
        IslandWidgetAttributes(name: "World")
    }
}

extension IslandWidgetAttributes.ContentState {
    fileprivate static var smiley: IslandWidgetAttributes.ContentState {
        IslandWidgetAttributes.ContentState(pose: "😀")
     }
     
     fileprivate static var starEyes: IslandWidgetAttributes.ContentState {
         IslandWidgetAttributes.ContentState(pose: "🤩")
     }
}

#Preview("Notification", as: .content, using: IslandWidgetAttributes.preview) {
   IslandWidgetLiveActivity()
} contentStates: {
    IslandWidgetAttributes.ContentState.smiley
    IslandWidgetAttributes.ContentState.starEyes
}
