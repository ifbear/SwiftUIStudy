//
//  Task+Extension.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import Foundation

extension Task {
    
    internal static func insert(title: String, content: String?, isDone: Bool = false, photos: Set<Photo>?) -> Task {
        let task: Task = .init(context: DataManager.shared.container.viewContext)
        task.id = UUID()
        task.title = title
        task.content = content
        task.isDone = isDone
        task.photos = photos
        task.time = Date()
        return task
    }
    
}
