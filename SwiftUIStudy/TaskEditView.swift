//
//  TaskEditView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

struct TaskEditView : View {
    
    @EnvironmentObject var userData: UserData
    
    private var task: Task
    private var bindingText: State<String>
    
    init(task: Task) {
        self.task = task
        self.bindingText = .init(wrappedValue: task.text)
    }
    
    var body: some View {
        ScrollView {
            if #available(iOS 15.0, *) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).stroke().frame(width: nil, height: 50.0, alignment: .center)
                    TextField("edit", text: bindingText.projectedValue).onSubmit {
                        guard let index = userData.tasks.firstIndex(of: task) else { return }
                        userData.tasks[index].text = bindingText.wrappedValue
                    }.padding()
                }.padding()
                
            } else {
                TextField("Edit", text: bindingText.projectedValue) { change in
                    guard let index = userData.tasks.firstIndex(of: task) else { return }
                    userData.tasks[index].text = bindingText.wrappedValue
                }
            }
        }
        .navigationTitle("Edit Task")
    }
}
