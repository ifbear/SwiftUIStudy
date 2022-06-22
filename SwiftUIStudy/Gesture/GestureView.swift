//
//  RotateAndMagnifyView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/21.
//

import Foundation
import SwiftUI
import Combine

//MARK: - 旋转缩放手势
struct RotateAndMagnifyView: View {
    
    struct RotateAndMagnify {
        var scale: CGFloat = 1
        var angle: Angle = .zero
    }
    
    @GestureState(resetTransaction: .init(animation: .easeInOut)) var gestureValue = RotateAndMagnify()

    var body: some View {
        let rotateAndMagnifyGesture = MagnificationGesture()
            .simultaneously(with: RotationGesture())
            .updating($gestureValue) { value, state, _ in
                state.scale = value.first ?? 1
                state.angle = value.second ?? .zero
            }
            .onEnded { value in
                print(value)
            }
        return Rectangle()
            .fill(LinearGradient(colors: [.blue, .green, .pink], startPoint: .top, endPoint: .bottom))
            .frame(width: 100, height: 100, alignment: .center)
            .shadow(radius: 8)
            .rotationEffect(gestureValue.angle)
            .scaleEffect(gestureValue.scale)
            .gesture(rotateAndMagnifyGesture)
    }
}

//MARK: - 轻扫手势
struct SwipeGesture: Gesture {
    enum Direction: String {
        case left, right, down, up
    }
    typealias Value = Direction
    
    typealias Body = AnyGesture<Value>
    
    private let minimumDistance: CGFloat
    private let coordinateSpace: CoordinateSpace
    
    init(minimumDistance: CGFloat = 10, coordinateSpace: CoordinateSpace = .local) {
        self.minimumDistance = minimumDistance
        self.coordinateSpace = coordinateSpace
    }
        
    var body: Body {
        AnyGesture(
                    DragGesture(minimumDistance: minimumDistance, coordinateSpace: coordinateSpace)
                        .map { value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height

                            if abs(horizontalAmount) > abs(verticalAmount) {
                                if horizontalAmount < 0 { return .left } else { return .right }
                            } else {
                                if verticalAmount < 0 { return .up } else { return .down }
                            }
                        }
                )
    }
    
}
extension View {
    func onSwipe(minimumDistance: CGFloat = 10,
                 coordinateSpace: CoordinateSpace = .local,
                 perform: @escaping (SwipeGesture.Direction) -> Void) -> some View {
        gesture(
            SwipeGesture(minimumDistance: minimumDistance, coordinateSpace: coordinateSpace)
                .onEnded(perform)
        )
    }
}

//MARK: - 长按
public struct PressGestureViewModifier: ViewModifier {
    @GestureState private var startTimestamp: Date?
    
    @State private var timePublisher: Publishers.Autoconnect<Timer.TimerPublisher>
    private var onPressing: (TimeInterval) -> Void
    private var onEnded: () -> Void

    public init(interval: TimeInterval = 0.016, onPressing: @escaping (TimeInterval) -> Void, onEnded: @escaping () -> Void) {
        _timePublisher = State(wrappedValue: Timer.publish(every: interval, tolerance: nil, on: .current, in: .common).autoconnect())
        self.onPressing = onPressing
        self.onEnded = onEnded
    }

    public func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .updating($startTimestamp, body: { _, current, _ in
                        if current == nil {
                            current = Date()
                        }
                    })
                    .onEnded { _ in
                        onEnded()
                    }
            )
            .onReceive(timePublisher, perform: { timer in
                if let startTimestamp = startTimestamp {
                    let duration = timer.timeIntervalSince(startTimestamp)
                    onPressing(duration)
                }
            })
    }
}

public extension View {
    func onPress(interval: TimeInterval = 0.016, onPressing: @escaping (TimeInterval) -> Void, onEnded: @escaping () -> Void) -> some View {
        modifier(PressGestureViewModifier(interval: interval, onPressing: onPressing, onEnded: onEnded))
    }
}


//MARK: - 位置点击
public struct TapWithLocation: ViewModifier {
    @State private var locations: CGPoint?
    private let count: Int
    private let coordinateSpace: CoordinateSpace
    private var perform: (CGPoint) -> Void

    init(count: Int = 1, coordinateSpace: CoordinateSpace = .local, perform: @escaping (CGPoint) -> Void) {
        self.count = count
        self.coordinateSpace = coordinateSpace
        self.perform = perform
    }

    public func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
                    .onChanged { value in
                        locations = value.location
                    }
                    .simultaneously(with:
                        TapGesture(count: count)
                            .onEnded {
                                perform(locations ?? .zero)
                                locations = nil
                            }
                    )
            )
    }
}

public extension View {
    func onTapGesture(count: Int = 1, coordinateSpace: CoordinateSpace = .local, perform: @escaping (CGPoint) -> Void) -> some View {
        modifier(TapWithLocation(count: count, coordinateSpace: coordinateSpace, perform: perform))
    }
}
