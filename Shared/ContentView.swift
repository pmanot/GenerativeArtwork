//
//  ContentView.swift
//  Shared
//
//  Created by Purav Manot on 09/11/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State var completeTree: [Branch] = []
    @State var step = false
    @ObservedObject var tree = Tree([[Node(radius: 10, coordinates: CGPoint(x: 220, y: 600), direction: -.pi/2, type: .seed, id: "B")]], wobble: 0.15, branchFrequency: 0.007, branchWobble: 0, branchAngle: .pi/3)
    
    var body: some View {
        GeometryReader { screen in
            ZStack {
                Text("\(tree.growingBranches.count)")
                ForEach(tree.allBranches.flatMap({ $0 }), id: \.hashValue){ node in
                    if node.id == "B" {
                        PencilShadedRectangle(shading: .black, lineWidth: 1.2)
                            .foregroundColor(Color(uiColor: Color.newGray.darker(componentDelta: -node.radius/40)))
                            .frame(width: node.radius*5, height: node.radius*2)
                            .rotationEffect(.radians(node.direction) + .degrees(90))
                            .position(x: node.coordinates.x, y: node.coordinates.y)
                            .zIndex(0)
                    } else {
                    }
                    /*
                    Dots(i: 2, d: node.radius*3)
                            .foregroundColor(node.type == .seed ? .green : node.type == .branch ? .brown : .black)
                            .rotationEffect(.radians(node.direction) + .degrees(90))
                            .position(x: node.coordinates.x, y: node.coordinates.y)
                            .offset(x: 15, y: 15)
                            .opacity(0.5)
                     */
                }
            }
            .animation(.easeIn(duration: 3), value: step)
            .onReceive(timer){ _ in
                tree.update(bounds: CGRect(x: 20, y: 20, width: screen.size.width - 35, height: screen.size.height - 40))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


