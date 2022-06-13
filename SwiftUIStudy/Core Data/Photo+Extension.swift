//
//  Photo+Extension.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/9.
//

import Foundation
import UIKit

extension Photo {
    
    internal static func insert(image: UIImage) -> Photo {
        let photo = Photo(context: DataManager.shared.container.viewContext)
        photo.image = image.pngData() ?? image.jpegData(compressionQuality: 1.0)
        return photo
    }
    
}
