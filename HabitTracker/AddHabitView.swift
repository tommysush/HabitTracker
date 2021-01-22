//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by 蘇聖泓 on 2021/1/22.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habit: Habit
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var description = ""
    @State private var completedTimes = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("項目名稱")
                        Spacer(minLength: 20)
                        TextField("請勿空白", text: $name)
                            .keyboardType(.default)
                    }
                    
                    HStack {
                        Text("簡介")
                        Spacer(minLength: 20)
                        TextField("可留白", text: $description)
                            .keyboardType(.default)
                    }
                    
                    HStack {
                        Text("已完成回數")
                        Spacer(minLength: 20)
                        TextField("輸入正整數", text: $completedTimes)
                            .keyboardType(.numberPad)
                    }
                }
                
                Button("取消") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitle("新增追蹤項目")
            .navigationBarItems(trailing: Button("儲存") {
                // 檢查"已完成回數"是否有正確輸入整數
                if let correctCount = Int(self.completedTimes) {
                    // 檢查"項目名稱"不是空字串、及"已完成回數"大於零
                    if !self.name.isEmpty && correctCount >= 0 {
                        // 確認輸入資料均無問題，將資料加入class，並關閉view
                        let activity = Activity(name: self.name, description: self.description, completedTimes: correctCount)
                        self.habit.activities.append(activity)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        //輸入資料有問題，彈出警示對話框
                        self.showingAlert = true
                    }
                } else {
                    //輸入資料有問題，彈出警示對話框
                    self.showingAlert = true
                }
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("輸入資料有誤"), message: Text("項目名稱請勿空白或重複、已完成回數請輸入大於等於0的整數"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habit: Habit())
    }
}
