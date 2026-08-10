//
//  CharacterSelectViewModel.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 8/10/26.
//

import Observation
import Foundation

@Observable
final class CharacterSelectViewModel {
    private let key = "selectCharacter"
    var selected: CharacterType
    
    init() {
        // UserDefaults에서 이전 선택 복원, 없으면 기본값
        if let raw = UserDefaults.standard.string(forKey: key),
           let character = CharacterType(rawValue: raw) {
            selected = character
        } else {
            selected = .cat
        }
    }
    
    func select(_ character: CharacterType) {
        // selected 갱신 + 저장
        selected = character
        UserDefaults.standard.set(character.rawValue, forKey: key)
    }
}

