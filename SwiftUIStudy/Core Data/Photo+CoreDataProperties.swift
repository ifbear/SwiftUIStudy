//
//  Photo+CoreDataProperties.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: Data?
    @NSManaged public var task: Task?

}

extension Photo : Identifiable {

}
