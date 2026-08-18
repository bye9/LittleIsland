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
        var mood: Mood
    }

    // Fixed non-changing properties about your activity go here!
    var character: CharacterType
}

struct IslandWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: IslandWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.attributes.character.emoji(for: context.state.mood))")
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
                    Text("Bottom \(context.attributes.character.emoji(for: context.state.mood))")
                    // more content
                }
            } compactLeading: {
                Text(context.attributes.character.emoji(for: context.state.mood))
            } compactTrailing: {
                Image(systemName: context.state.mood.symbol)
            } minimal: {
                Text("\(context.state.mood)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension IslandWidgetAttributes {
    fileprivate static var preview: IslandWidgetAttributes {
        IslandWidgetAttributes(character: .cat)
    }
}

extension IslandWidgetAttributes.ContentState {
    fileprivate static var normal: IslandWidgetAttributes.ContentState {
        IslandWidgetAttributes.ContentState(mood: .normal)
    }
    
    fileprivate static var relaxing: IslandWidgetAttributes.ContentState {
        IslandWidgetAttributes.ContentState(mood: .relaxing)
    }
    
    fileprivate static var sleeping: IslandWidgetAttributes.ContentState {
        IslandWidgetAttributes.ContentState(mood: .sleeping)
    }
}

#Preview("Compact", as: .content, using: IslandWidgetAttributes.preview) {
   IslandWidgetLiveActivity()
} contentStates: {
    IslandWidgetAttributes.ContentState.normal
    IslandWidgetAttributes.ContentState.relaxing
    IslandWidgetAttributes.ContentState.sleeping
}

#Preview("Notification", as: .dynamicIsland(.compact), using: IslandWidgetAttributes.preview) {
   IslandWidgetLiveActivity()
} contentStates: {
    IslandWidgetAttributes.ContentState.normal
    IslandWidgetAttributes.ContentState.relaxing
    IslandWidgetAttributes.ContentState.sleeping
}
