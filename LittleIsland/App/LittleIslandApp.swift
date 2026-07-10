//
//  LittleIslandApp.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 6/30/26.
//

import SwiftUI

@main
struct LittleIslandApp: App {
    @State private var manager = ActivityManager()
    @Environment(\.scenePhase) var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
        }        
        .onChange(of: phase) { oldValue, newValue in
            if newValue == .active {
                print("[App] active")
                manager.refreshActivity()
            } else if newValue == .inactive {
                print("[App] inactive")
            } else if newValue == .background {
                print("[App] background")
            }
        }
    }
}
