//
//  ActivityManager.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 7/6/26.
//

import Observation
import ActivityKit
import Foundation

@Observable
class ActivityManager {
    var isActive: Bool = false
    
    func startActivity() {
        // Live Activity가 활성 가능한 상태인지 먼저 확인
        if ActivityAuthorizationInfo().areActivitiesEnabled == false {
            return
        }
        
        // attributes(정적) + 초기 ContentState(동적) 준비
        let attributes = IslandWidgetAttributes(name: "Sample")
        let hour = Calendar.current.component(.hour, from: Date())
        let mood = MoodPolicy.policy(hour: hour)
        let contentState = IslandWidgetAttributes.ContentState(mood: mood)
        
        if let activity = Activity<IslandWidgetAttributes>.activities.first {
            // update
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: nil))
                isActive = true
            }
            
        } else {
            // request
            do {
                let activity = try Activity.request(attributes: attributes, content: ActivityContent(state: contentState, staleDate: nil))
                print(activity.id)
                isActive = true
            } catch {
                print("LiveActivityManager: Error in LiveActivityManager: \(error.localizedDescription)")
            }
        }
    }
}

