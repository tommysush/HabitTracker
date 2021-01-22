//
//  TrackHabitView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

struct TrackHabitView: View {
    // 告知TrackHabitView存在一個Habit類型的物件，以及一個index
    @ObservedObject var habit: Habit
    var index: Int

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(habit.activities[index].description)
                    Text("已完成回數: ")
                    Text("\(habit.activities[index].completedTimes)")
                    
                    Button("增加1回") {
                        self.habit.activities[self.index].completedTimes += 1
                    }
                }
            }
            .navigationBarTitle(habit.activities[index].name)
        }
    }
}

struct TrackHabitView_Previews: PreviewProvider {
    static var previews: some View {
        TrackHabitView(habit: Habit(), index: 0)
    }
}
