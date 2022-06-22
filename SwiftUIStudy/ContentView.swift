//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import SwiftUI


struct ContentView: View {
    
    //MARK: - demo1
//    @State private var direction: String = ""
//    var body: some View {
//        VStack {
//           RotateAndMagnifyView()
//                .overlay(Text(direction))
//                .onSwipe { value in
//                    self.direction = value.rawValue
//                }
//        }
//    }
    
    
    //MARK: demo2
//        @State var scale: CGFloat = 1
//        @State var duration: TimeInterval = 0
//
//        var body: some View {
//            VStack {
//                Circle()
//                                .fill(scale == 1 ? .blue : .orange)
//                                .frame(width: 50, height: 50)
//                                .scaleEffect(scale)
//                                .overlay(Text(String(format: "%f", duration)))
//                                .onPress { duration in
//                                    self.duration = duration
//                                    scale = 1 + duration * 2
//                                } onEnded: {
//                                    if duration > 1 {
//                                        withAnimation(.easeInOut(duration: 2)) {
//                                            scale = 1
//                                        }
//                                    } else {
//                                        withAnimation(.easeInOut) {
//                                            scale = 1
//                                        }
//                                    }
//                                    duration = 0
//                                }
//            }
//        }
    
        //MARK: - demo3
        @State var unitPoint: UnitPoint = .center
        var body: some View {
            Rectangle()
                .fill(RadialGradient(colors: [.yellow, .orange, .red, .pink], center: unitPoint, startRadius: 10, endRadius: 170))
                .frame(width: 300, height: 300)
                .onTapGesture(count:2) { point in
                    withAnimation(.easeInOut) {
                        unitPoint = UnitPoint(x: point.x / 300, y: point.y / 300)
                    }
                }
        }
}
