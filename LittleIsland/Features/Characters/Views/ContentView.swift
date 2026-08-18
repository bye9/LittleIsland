//
//  ContentView.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 6/30/26.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @Environment(ActivityManager.self) var manager: ActivityManager

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Button {
//                manager.toggleActivity()
            } label: {
                Text(manager.isActive ? "지금 갱신" : "시작하기")
            }
            
            if manager.isActive {
                Text("함께 있는중")
            } else {
                Text("표시없음")
            }
        }
        .padding()
    }
    
    
}

#Preview {
    ContentView()
        .environment(ActivityManager())
}
