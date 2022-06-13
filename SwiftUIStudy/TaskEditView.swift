//
//  TaskEditView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

struct TaskEditView : View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private var task: Task
    private var bindingTitle: State<String>
    private var bindingContent: State<String>
    private var bindingPhotos: State<[UIImage]>
    
    @State private var isSave: Bool = false
    
    @State private var showImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    @State private var showPreview: Bool = false
    @State private var showImage: UIImage?
    
    init(task: Task) {
        self.task = task
        bindingTitle = .init(wrappedValue: task.title)
        bindingContent = .init(wrappedValue: task.content ?? "")
        bindingPhotos = .init(wrappedValue: [])
    }
    
    var body: some View {
        ScrollView {
            if #available(iOS 15.0, *) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke()
                        .frame(width: nil, height: 50.0, alignment: .center)
                    HStack {
                        Text("主题")
                            .foregroundColor(.pink)
                            .bold()
                            .padding(.leading)
                        
                        TextField("输入主题", text: bindingTitle.projectedValue).onSubmit {
                            task.title = bindingTitle.wrappedValue
                        }.padding()
                    }
                }.padding()
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke()
                        .frame(width: nil, height: 50.0, alignment: .center)
                    HStack {
                        Text("描述")
                            .foregroundColor(.pink)
                            .bold()
                            .padding(.leading)
                        
                        TextField("输入描述", text: bindingContent.projectedValue).onSubmit {
                            task.content = bindingContent.wrappedValue
                        }.padding()
                    }
                }.padding()
                Spacer()
                HStack {
                    Image(systemName: "folder.badge.plus").onTapGesture {
                        showImagePicker = true
                    }.sheet(isPresented: $showImagePicker, onDismiss: {
                        showImagePicker = false
                    }) {
                        ImagePicker(image: $inputImage)
                    }.onChange(of: inputImage) { newValue in
                        guard let image = newValue else { return }
                        bindingPhotos.wrappedValue.append(image)
                    }
                    Spacer()
                }.padding()
                Spacer()
                LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))], spacing: 10) {
                    ForEach(bindingPhotos.wrappedValue, id: \.self) { image in
                        if let image = image {
                            ImageView(image: .constant(image))
                                .frame(width: 100, height: 100, alignment: .center)
                        } else {
                            Image(systemName: "photo")
                        }
                    }
                }
                
            } else {
                TextField("Edit", text: bindingTitle.projectedValue) { change in

                }
            }
        }
        .navigationTitle("Edit Task")
        .toolbar(content: {
            Button {
                isSave = true
                for image in bindingPhotos.wrappedValue {
                    task.addToPhotos(.insert(image: image))
                }
                DataManager.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }

        })
        .onDisappear {
            if isSave == false {
                DataManager.shared.delete(task)
            }
        }
    }
}
