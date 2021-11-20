//
//  ShadedRectangle.swift
//  GenerativeArt
//
//  Created by Purav Manot on 14/11/21.
//

import SwiftUI

struct ShadedRectangle: View {
    let shadingColor: Color
    init(shading: Color = .black){
        self.shadingColor = shading
    }
    var body: some View {
        GeometryReader { screen in
            Rectangle()
                .mask(Rectangle().frame(height: screen.size.height/1.2))
                .overlay {
                    ShadingLine().stroke()
                        .foregroundColor(shadingColor)
                }
        }
    }
}

struct PencilShadedRectangle: View {
    let shadingColor: Color
    let lineWidth: CGFloat
    init(shading: Color = .black, lineWidth: CGFloat = 1){
        self.shadingColor = shading
        self.lineWidth = lineWidth
    }
    var body: some View {
        GeometryReader { screen in
            Rectangle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(shadingColor)
                .mask(Rectangle().frame(height: screen.size.height/1.1))
                .overlay {
                    ShadingLine().stroke()
                        .foregroundColor(shadingColor)
                }
        }
    }
}

struct ShadedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ShadedRectangle()
    }
}


struct ShadingLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if !rect.isEmpty {
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
            path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.maxY/4))
            path.addLine(to: CGPoint(x: CGFloat.random(in: 0..<rect.midX), y: rect.midY + rect.maxY/4))
            path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.maxY/2))
            path.addLine(to: CGPoint(x: CGFloat.random(in: 0..<rect.midX), y: rect.midY + rect.maxY/2))
            path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.maxY/3))
            path.addLine(to: CGPoint(x: CGFloat.random(in: 0..<rect.midX), y: rect.midY + rect.maxY/3))
            path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.maxY/1.5))
            path.addLine(to: CGPoint(x: CGFloat.random(in: 0..<rect.midX), y: rect.midY + rect.maxY/1.5))
            path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.maxY/1.4))
            path.addLine(to: CGPoint(x: CGFloat.random(in: 0..<rect.midX), y: rect.midY + rect.maxY/1.4))
        }
        return path
    }
}


struct Dots: View {
    @State var r1: CGFloat = 0
    @State var r2: CGFloat = 0
    @State var opacity: Double = 0
    let i: Int
    let d: CGFloat
    init(i: Int, d: CGFloat){
        self.i = i
        self.d = d
    }
    var body: some View {
        GeometryReader { screen in
            ForEach(0..<i){ _ in
                Group {
                    Circle()
                    Circle()
                        .offset(x: r1)
                        .opacity(1 - opacity)
                    Circle()
                        .offset(y: r2)
                        .opacity(opacity)
                }
                .position(x: CGFloat.random(in: 0..<screen.size.width/2), y: CGFloat.random(in: 0..<screen.size.height))
                .frame(width: CGFloat.random(in: 0..<d))
            }
            .onAppear {
                r1 = CGFloat.random(in: 0..<screen.size.width/2)
                r2 = CGFloat.random(in: 0..<screen.size.height/2)
                opacity = Double.random(in: 0..<1)
            }
        }
        .drawingGroup()
    }
}
