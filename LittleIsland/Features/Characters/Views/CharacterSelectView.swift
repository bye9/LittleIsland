//
//  CharacterSelectView.swift
//  LittleIsland
//
//  Created by JeongHwan Seok on 7/27/26.
//

import SwiftUI

struct CharacterSelectView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let characters = CharacterType.allCases
    
    @State private var vm = CharacterSelectViewModel()
    @Environment(ActivityManager.self) var manager: ActivityManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("작은섬")
                .font(.largeTitle)
                .bold()
            Text("곁에 둘 친구를 골라요")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 100, height: 100)
                    
                Text(vm.selected.emoji(for: .normal))
                    .font(.system(size: 60))

            }.frame(maxWidth: .infinity)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(characters, id: \.self) { character in
                    Button(action: {
                        vm.select(character)
                        manager.setCharacter(to: character)
                    }) {
                        CharacterCell(character: character, isSelected: vm.selected == character)
                            .frame(width: 70, height: 70)
                    }
                }
                
                ZStack {
                    Circle().stroke(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: "plus")
                }
            }
            .padding(.bottom)
            
            if manager.isActive {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle")     // fill 없이
                    Text("Dynamic Island에 있어요")
                }
                .foregroundStyle(.green).bold()
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.4), in: RoundedRectangle(cornerRadius: 12))
            }
            
            Spacer()
        }
        .padding(20)
        
        
    }
}

struct CharacterCell: View {
    let character: CharacterType   // 밖에서 받을 값
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2), lineWidth: isSelected ? 4 : 2)
            Text(character.emoji(for: .normal))
                .font(Font.system(size: 30))
        }
    }
}

#Preview {
    CharacterSelectView()
        .environment(ActivityManager())
}
