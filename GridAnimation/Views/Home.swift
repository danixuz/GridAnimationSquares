//
//  Home.swift
//  GridAnimation
//
//  Created by Daniel Spalek on 15/08/2022.
//

import SwiftUI

struct Home: View {
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
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.orange)
                    }
                    .padding(5)
                    .frame(height: width)
                }
            }
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
