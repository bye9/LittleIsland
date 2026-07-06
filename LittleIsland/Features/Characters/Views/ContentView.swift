//
//  ContentView.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 6/30/26.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Button(action: startActivity) {
                Text("Hello, world!")
            }
        }
        .padding()
    }
    
    func startActivity() {
        // 1. Live Activity가 활성 가능한 상태인지 먼저 확인
        if ActivityAuthorizationInfo().areActivitiesEnabled == false {
            return
        }
        
        // 2. attributes(정적) + 초기 ContentState(동적) 준비
        let attributes = IslandWidgetAttributes(name: "Sample")
        
        let hour = Calendar.current.component(.hour, from: Date())
        let mood = MoodPolicy.policy(hour: hour)
        
        let contentState = IslandWidgetAttributes.ContentState(mood: mood)
        
        // 3. Activity.request(for:content:)로 시작
        do {
            let activity = try Activity.request(attributes: attributes, content: ActivityContent(state: contentState, staleDate: nil))
            print(activity.id)
        } catch {
            print("LiveActivityManager: Error in LiveActivityManager: \(error.localizedDescription)")
        }
    
    }
}

#Preview {
    ContentView()
}
