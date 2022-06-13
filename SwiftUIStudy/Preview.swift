//
//  Preview.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/9.
//

import SwiftUI
import QuickLook
import UIKit

class ImageItem: NSObject, QLPreviewItem {
    let image: UIImage
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    var previewItemTitle: String? {
        return nil
    }
    
    var previewItemURL: URL? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("temp.png")
        if FileManager.default.fileExists(atPath: url.path) {
           try? FileManager.default.removeItem(at: url)
        }
        if let data = image.pngData() ?? image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: url)
            if FileManager.default.fileExists(atPath: url.path) {
               return url
            }
        }
        return nil
    }
}

struct Preview: UIViewControllerRepresentable {
    
    @State var items: [QLPreviewItem]
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let previewController = QLPreviewController()
        previewController.delegate = context.coordinator
        previewController.dataSource = context.coordinator
        return previewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    class Coordinator: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
        
        let present: Preview
        
        init(_ present: Preview) {
            self.present = present
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            self.present.items.count
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            self.present.items[index]
        }
    }
    
    
}
