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
    
    // 초기 ContentState(동적) 준비
    private func makeContentState() -> IslandWidgetAttributes.ContentState {
        let hour = Calendar.current.component(.hour, from: Date())
        let mood = MoodPolicy.policy(hour: hour)
        let contentState = IslandWidgetAttributes.ContentState(mood: mood)
        
        return contentState
    }
    
    func startActivity(character: CharacterType) {
        // Live Activity가 활성 가능한 상태인지 먼저 확인
        if ActivityAuthorizationInfo().areActivitiesEnabled == false {
            return
        }
        
        let attributes = IslandWidgetAttributes(character: character)
        let contentState = makeContentState()
        // request
        do {
            let activity = try Activity.request(attributes: attributes, content: ActivityContent(state: contentState, staleDate: nil))
            print(activity.id)
            isActive = true
        } catch {
            print("LiveActivityManager: Error in LiveActivityManager: \(error.localizedDescription)")
        }
    }
    
    func refreshActivity() {
        let contentState = makeContentState()
        if let activity = Activity<IslandWidgetAttributes>.activities.first {
            // update
            Task {
                await activity.update(ActivityContent(state: contentState, staleDate: nil))
            }
        }
    }

    func endActivity() async {
        if let activity = Activity<IslandWidgetAttributes>.activities.first {
            // update
            await activity.end(nil, dismissalPolicy: .immediate)
            isActive = false
        }
    }
    
    func setCharacter(to character: CharacterType) {
        if let activity = Activity<IslandWidgetAttributes>.activities.first {
            if activity.attributes.character == character {
                refreshActivity()
            } else {
                Task {
                    await endActivity()
                    startActivity(character: character)
                }
            }
        } else {
            startActivity(character: character)
        }
    }
}

