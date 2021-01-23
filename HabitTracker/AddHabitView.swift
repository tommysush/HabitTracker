//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

// 自訂view用於項目的標題
struct ColumnTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .frame(width: 100, height: 40, alignment: .leading)
        Spacer(minLength: 20)
    }
}

struct AddHabitView: View {
    // 告知AddHabitView有一個Habit物件的存在，並透過@Environment取得頁面顯示狀態
    @ObservedObject var habit: Habit
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var description = ""
    @State private var completedTimes = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    ColumnTitle(title: "項目名稱")
                    TextField("請勿空白", text: $name)
                        .keyboardType(.default)
                }
                
                HStack {
                    ColumnTitle(title: "項目簡述")
                    TextField("可省略", text: $description)
                        .keyboardType(.default)
                }
                
                HStack {
                    ColumnTitle(title: "已完成回數")
                    TextField("輸入正整數", text: $completedTimes)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 取消鈕
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                // 標題
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "gauge.badge.plus")
                        Text("新增追蹤").font(.headline)
                    }
                    .font(.title)
                }
                // 儲存鈕
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("儲存") {
                        if let realTimes = Int(self.completedTimes) {
                            if !self.name.isEmpty && realTimes >= 0 {
                                // 確認輸入資料無問題，將資料加入class並關閉view
                                let activity = Activity(name: self.name, description: self.description, completedTimes: realTimes)
                                self.habit.activities.append(activity)
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                // 輸入資料有問題，彈出警示對話框
                                self.showingAlert = true
                            }
                        } else {
                            //輸入資料有問題，彈出警示對話框
                            self.showingAlert = true
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("輸入資料有誤"), message: Text("項目名稱請勿空白、已完成回數請輸入正整數"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habit: Habit())
    }
}
