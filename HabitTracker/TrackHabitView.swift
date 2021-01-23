//
//  TrackHabitView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

struct TrackHabitView: View {
    // 告知TrackHabitView有一個Habit物件的存在，以及一個index
    @ObservedObject var habit: Habit
    var index: Int

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // 減少該項目次數的按鈕
                    Button(action: {
                        self.habit.activities[self.index].completedTimes -= 1
                    }, label: {
                        Image(systemName: "gobackward.minus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    })
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("已完成 ")
                            Text("\(habit.activities[index].completedTimes)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                            Text(" 回")
                        }
                    }
                    
                    Spacer()
                    
                    // 增加該項目次數的按鈕
                    Button(action: {
                        self.habit.activities[self.index].completedTimes += 1
                    }, label: {
                        Image(systemName: "goforward.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    })
                }
                .padding(30)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // TrackHabitView的頁面標題
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(self.habit.activities[index].name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(self.habit.activities[index].description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct TrackHabitView_Previews: PreviewProvider {
    static var previews: some View {
        TrackHabitView(habit: Habit(), index: 30)
    }
}
