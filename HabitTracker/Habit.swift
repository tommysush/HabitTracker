//
//  Habit.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import Foundation

class Habit: ObservableObject {
    @Published var activities: [Activity] {
        // if "activites" changes, encodes it and saves it into UserDefaults
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Acts")
            }
        }
    }
    
    // when app starts, loads data from UserDefaults and decodes it into "activities"
    init() {
        if let acts = UserDefaults.standard.data(forKey: "Acts") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: acts) {
                self.activities = decoded
                return
            }
        }
        
        // fail to load data, initialize "activities" with empty
        self.activities = []
    }
}
