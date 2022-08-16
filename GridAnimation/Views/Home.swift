//
//  Home.swift
//  GridAnimation
//
//  Created by Daniel Spalek on 15/08/2022.
//

import SwiftUI

struct Home: View {
    
    // MARK: Gesture State
    @GestureState var location: CGPoint = .zero
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            // MARK: to fit into the whole view, we will calculate the item count with the help of height and width.
            // In a row, we have 10 items.
            
            let width = (size.width / 10)
            // Multiplying each row count
            let itemCount = Int((size.height / width).rounded()) * 10 // how many squares can we fit in each column
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10), spacing: 0) {
                ForEach(0..<itemCount, id: \.self){ _ in
                    GeometryReader { innerProxy in
                        let rect = innerProxy.frame(in: .named("GESTURE"))
                        let scale = itemScale(rect: rect, size: size)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.orange)
                            .scaleEffect(scale)
                    }
                    .padding(5)
                    .frame(height: width)
                }
            }
        }
        .padding(15)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location, body: { value, out, _ in
                    out = value.location // out is sent to the "location" gesture state variable we created. we are sending the updated value's location.
                })
            // as the DragGesture's state changes (as we drag) it will update the gesture satate variable we created with a new point representing where we tapped / dragged to.
        )
        .coordinateSpace(name: "GESTURE")
        .animation(.easeInOut, value: location == .zero)
    }
    
    // MARK: We will calculate the size for each square with the distance equation.
    func itemScale(rect: CGRect, size: CGSize) -> CGFloat {
        let a = location.x - rect.midX
        let b = location.y - rect.midY
        
        let root = sqrt((a * a) + (b * b))
        let diagonalValue = sqrt((size.width * size.width) + (size.height * size.height))
        
        let scale = root / diagonalValue
        let modifiedScale = location == .zero ? 1 : (1 - scale) // if finger is not touching then we don't want it to be active.
        return modifiedScale > 0 ? modifiedScale : 0.001
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
