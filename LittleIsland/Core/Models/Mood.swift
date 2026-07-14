//
//  Mood.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 7/6/26.
//

enum Mood: String, Codable, Hashable {
    case normal, relaxing, sleeping
    
    var characterType: String {
        switch self {
        case .normal:   return "🐱"
        case .relaxing: return "🛀"
        case .sleeping: return "😴"
        }
    }
    
    var symbol: String {
        switch self {
        case .normal:   return "sun.max"   // 태양 계열
        case .relaxing: return "moon"   // 달 계열
        case .sleeping: return "moon.stars"   // 별 계열
        }
    }
}
