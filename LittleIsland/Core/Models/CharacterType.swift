//
//  CharacterType.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 7/18/26.
//

enum CharacterType: String, Codable, Hashable {
    case cat, dog, turtle, fish, frog
    
    func assetName(for mood: Mood) -> String {
        "\(self.rawValue)_\(mood.rawValue)"
    }
    
    func emoji(for mood: Mood) -> String {
        switch (self, mood) {
        case (.cat, .normal):   return "🐱"
        case (.cat, .relaxing): return "😺"
        case (.cat, .sleeping): return "😴"
        case (.dog, _): return "🐕"
        case (.turtle, _): return "🐢"
        case (.fish, _): return "🐟"
        case (.frog, _): return "🐸"
        }
    }
}
