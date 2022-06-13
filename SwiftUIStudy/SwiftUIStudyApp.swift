//
//  SwiftUIStudyApp.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI

@main
struct SwiftUIStudyApp: App {
    let manager = DataManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
    
    
}
