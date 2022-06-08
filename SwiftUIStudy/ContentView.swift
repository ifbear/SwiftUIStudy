//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    @State var isEditing: Bool = false
    @State var bindingText: String = ""
    
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    
    var body: some View {
        NavigationView {
            List {
                if #available(iOS 15.0, *), !isEditing {
                    HStack {
                        TextField("add new task", text: $bindingText).onSubmit {
                            userData.tasks.insert(.init(text: bindingText, isFinish: false), at: 0)
                            bindingText = ""
                        }
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            Image(systemName: "folder.badge.plus")
                        }
                        .onChange(of: inputImage) { newValue in
                            print(newValue)
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $inputImage)
                        }
                    }
                    
                } else if !isEditing {
                    TextField("add new task", text: $bindingText) { changed in
                        print(changed)
                    }
                }
                ForEach(self.userData.tasks) { task in
                    HStack {
                        TaskView(task: task, isEditing: $isEditing)
                    }
                }
            }
            .navigationTitle("ToDo")
            .toolbar {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Add")
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
