//
//  Task+CoreDataProperties.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var content: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var time: Date
    @NSManaged public var photos: Set<Photo>?

}

// MARK: Generated accessors for photos
extension Task {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: Set<Photo>)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: Set<Photo>)

}

extension Task : Identifiable {

}
