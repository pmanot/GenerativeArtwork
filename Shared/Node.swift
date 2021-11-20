//
//  Node.swift
//  GenerativeArt
//
//  Created by Purav Manot on 09/11/21.
//

import Foundation
import SwiftUI

typealias Branch = [Node]

struct Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(radius)
        hasher.combine(coordinates.x)
        hasher.combine(coordinates.y)
    }
    
    var id: String
    var radius: CGFloat
    var coordinates: CGPoint
    var direction: CGFloat
    var type: NodeType
    
    init(radius: CGFloat = 10, coordinates: CGPoint = CGPoint(x: 200, y: 30), direction: CGFloat = .pi/2, type: NodeType = .seed, id: String = "A"){
        self.id = id
        self.radius = radius
        self.coordinates = coordinates
        self.direction = direction
        self.type = type
    }
    
    init(previous n: Node, direction: CGFloat, type: NodeType){
        self.direction = direction
        self.type = type
        switch n.type {
            case .seed:
                self.radius = n.radius
            case .branch:
                self.radius = n.radius/1.2
            case .regular:
                self.radius = n.radius - 0.05
            case .end:
                self.radius = 0
        }
        self.id = n.id
        self.coordinates = n.coordinates.step(angle: direction, radius: n.radius/2)
    }
}



enum NodeType {
    case seed
    case regular
    case branch
    case end
}

func extend(branch: Branch, wobble: CGFloat, branchFrequency: CGFloat) -> [Node] {
    var extendedBranch = branch
    if branch.last != nil {
        switch branch.last!.type {
            case .seed:
                extendedBranch.append(Node(previous: branch.last!, direction: branch.last!.direction, type: .regular))
            case .regular:
                if branch.last!.radius > 0.1 {
                    extendedBranch.append(Node(previous: branch.last!, direction: branch.last!.direction.wobble(wobble), type: probability(branchFrequency) ? .branch : .regular))
                } else {
                    extendedBranch.append(Node(previous: branch.last!, direction: branch.last!.direction.wobble(wobble), type: .end))
                }
            case .branch:
                extendedBranch.append(Node(previous: branch.last!, direction: branch.last!.direction.wobble(wobble), type: .end))
            case .end:
                return extendedBranch
        }
    }
    return extendedBranch
}





func probability(_ p: Double) -> Bool {
    return Int.random(in: 0...100_00) <= Int(p*100_000)
}



