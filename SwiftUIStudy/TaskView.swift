//
//  ItemView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var userData: UserData
    
    let task: Task
    @Binding var isEditing: Bool
    
    var body: some View {
        return HStack {
            if self.isEditing {
                NavigationLink {
                    TaskEditView(task: task).environmentObject(self.userData)
                } label: {
                    Text(self.task.text)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)
                }
            } else {
                Button {
                    guard let index = userData.tasks.firstIndex(of: task) else { return }
                    userData.tasks[index].isFinish.toggle()
                } label: {
                    Text(self.task.text)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)
                }
                Spacer()
                if task.isFinish {
                    Image(systemName: "checkmark").foregroundColor(.green)
                }
            }
        }
    }
}
