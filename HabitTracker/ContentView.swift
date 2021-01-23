//
//  ContentView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

// 自訂List項目的view
struct ListItem: View {
    var name: String
    var description: String
    var completedTimes: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("已完成")
                    .foregroundColor(.secondary)
                Text("\(completedTimes) 回")
                    .font(.headline)
            }
        }
        .frame(height: 50)
    }
}

struct ContentView: View {
    // 初始化一個Habit物件，有資料後每次開啟app，init()都會自動載入已存資料
    @ObservedObject var habit = Habit()
    
    // 新增狀態變數：一個代表"View-新增追蹤"的開啟狀態，另一個是"編輯模式"狀態
    @State private var showingAddActivity = false
    @State private var isEditMode = false
    
    var body: some View {
        NavigationView {
            List {
                // 關鍵：以"陣列Activity"的index作為傳遞給下層view的資料
                ForEach(habit.activities.indices, id: \.self) { index in
                    NavigationLink(destination: TrackHabitView(habit: self.habit, index: index)) {
                        ListItem(name: self.habit.activities[index].name, description: self.habit.activities[index].description, completedTimes: self.habit.activities[index].completedTimes)
                    }
                }
                // onDelete can only be used on ForEach
                .onDelete(perform: removeActivities)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 主畫面的編輯模式切換按鈕
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                // App主畫面標題
                ToolbarItem(placement: .principal) {
                    Text("Habit Tracker")
                        .font(.title)
                        .fontWeight(.bold)
                }
                // "新增追蹤"的按鈕
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddActivity = true
                    }, label: {
                        HStack {
                            Image(systemName: "rectangle.stack.badge.plus")
                        }
                    })
                }
            }
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
