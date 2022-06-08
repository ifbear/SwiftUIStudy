//
//  UserData.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import Foundation
import UIKit
import SwiftUI
import Combine

private let defaultTasks: [Task] = [
    .init(text: "测试1", isFinish: false),
    .init(text: "测试2", isFinish: false)
]
class UserData: ObservableObject {
    var objectWillChange = PassthroughSubject<UserData, Never>()
    
    @UserDefaultValue(key: "tasks", defaultValue: defaultTasks)
    var tasks: [Task] {
        didSet {
            print(#function)
            objectWillChange.send(self)
        }
    }
}

struct Task: Equatable, Hashable, Codable, Identifiable {
    let id: UUID
    var text: String
    var isFinish: Bool
    
    init(text: String, isFinish: Bool) {
        self.id = UUID()
        self.text = text
        self.isFinish = isFinish
    }
}

@propertyWrapper
struct UserDefaultValue<Value: Codable> {
    let key: String
    let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            let data = UserDefaults.standard.object(forKey: key)
            let value = data.flatMap({ try? JSONDecoder().decode(Value.self, from: $0 as! Data) })
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
