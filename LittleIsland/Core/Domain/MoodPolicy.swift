//
//  MoodPolicy.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 7/6/26.
//

enum MoodPolicy {
    static func policy(hour: Int) -> Mood {
        switch hour {
        case 6..<18:
            return .normal
        case 18..<22:
            return .relaxing
        case 22...23, 0..<6:
            return .sleeping
        default:
            return .normal
        }
    }
    
}
