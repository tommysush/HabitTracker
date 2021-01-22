//
//  ContentView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

struct ContentView: View {
    // 初始化一個Habit物件，有資料後每次開啟app，init()都會自動載入已存資料
    @ObservedObject var habit = Habit()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // 關鍵：以activity的id作為傳遞給下層view的資料，而不用activity本身
                    ForEach(habit.activities.indices, id: \.self) { index in
                        NavigationLink(destination: TrackHabitView(habit: self.habit, index: index)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(self.habit.activities[index].name)
                                    Text(self.habit.activities[index].description)
                                }
                                Spacer()
                                Text("已完成: \(self.habit.activities[index].completedTimes) 回")
                            }
                        }
                    }
                    // onDelete can only be used on ForEach
                    .onDelete(perform: removeActivities)
                }
                
                // 新增habit的按鈕
                Button("新增追蹤項目") {
                    self.showingAddActivity = true
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: $showingAddActivity, content: {
            AddHabitView(habit: self.habit)
        })
    }
    
    // remove function for user to swipe away activities they don't wanna track
    func removeActivities(at offsets: IndexSet) {
        self.habit.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
