//
//  ItemView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

struct TaskView: View {
    
    let task: Task
    @Binding var isEditing: Bool
    
    var body: some View {
        return HStack {
            if self.isEditing {
                NavigationLink {
//                    TaskEditView(task: task)
                } label: {
                    Text(self.task.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)
                }
            } else {
                Button {
//                    guard let index = userData.Task.firstIndex(of: task) else { return }
//                    userData.Task[index].isFinish.toggle()
                } label: {
                    Text(self.task.title)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)
                }
                Spacer()
                if task.isDone {
                    Image(systemName: "checkmark").foregroundColor(.green)
                }
            }
        }
    }
}
