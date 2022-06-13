//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @State var isEditing: Bool = false
    @State var bindingText: String = ""
    
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var tasks: FetchedResults<Task> {
        didSet {
            print("=====", tasks.count)
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        TaskView(task: task, isEditing: $isEditing)
                    }
                }
            }
            .navigationTitle("ToDo")
            .toolbar {
                HStack {
                    NavigationLink {
                        let task = Task.insert(title: "", content: nil, photos: nil)
                        TaskEditView(task: task)
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Button {
                        self.isEditing.toggle()
                    } label: {
                        Text((self.isEditing == true ? "Done" : "Edit"))
                    }
                }
                
            }
        }
        
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(, inputImage: <#Binding<UIImage?>#>)
//    }
//}
