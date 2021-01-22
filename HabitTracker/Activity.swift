//
//  Activity.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    var name: String // 項目名稱
    var description: String // 項目的簡單描述
    var completedTimes: Int // 已完成該項目的累計次數
}
