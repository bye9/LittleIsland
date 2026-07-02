//
//  IslandWidgetBundle.swift
//  IslandWidget
//
//  Created by JeongHwan Seok on 7/2/26.
//

import WidgetKit
import SwiftUI

@main
struct IslandWidgetBundle: WidgetBundle {
    var body: some Widget {
        IslandWidget()
        IslandWidgetLiveActivity()
    }
}
