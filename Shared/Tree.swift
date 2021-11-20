//
//  Tree.swift
//  GenerativeArt
//
//  Created by Purav Manot on 10/11/21.
//

import Foundation
import SwiftUI

class Tree: ObservableObject {
    
    @Published var growingBranches: [Branch] = []
    
    var staticBranches: [Branch] = []
    var allBranches: [Branch] {
        staticBranches + growingBranches
    }
    
    var wobble: CGFloat
    var branchFrequency: CGFloat
    var branchWobble: CGFloat
    var branchAngle: CGFloat
    
    init(_ completeTree: [Branch], wobble: CGFloat, branchFrequency: CGFloat, branchWobble: CGFloat, branchAngle: CGFloat){
        staticBranches =  completeTree.filter { ($0.last?.type ?? .regular) == .end }
        growingBranches = completeTree.filter { ($0.last?.type ?? .regular) != .end }
        self.wobble = wobble
        self.branchFrequency = branchFrequency
        self.branchWobble = branchWobble
        self.branchAngle = branchAngle
    }
    
    func update(bounds: CGRect){
        if !growingBranches.isEmpty {
            grow(&growingBranches, staticBranches: &staticBranches, wobble: self.wobble, branchWobble: self.branchWobble, branchFrequency: self.branchFrequency, branchAngle: self.branchAngle, bounds: bounds)
        }
    }
    
}


func grow(_ tree: inout [[Node]], staticBranches: inout [Branch], wobble: CGFloat = 0.5, branchWobble: CGFloat = 0.3, branchFrequency: CGFloat, branchAngle: CGFloat = (.pi/2), bounds: CGRect){
    var updatedTree: [[Node]] = []
    for branch in tree {
        if branch.last != nil {
            if bounds.contains(branch.last!.coordinates) {
                switch branch.last!.type {
                    case .branch:
                        let newBranch = [Node(previous: branch.last!, direction: (branchAngle/2) + branch.last!.direction.wobble(branchWobble), type: .regular)]
                        let newBranch2 = [Node(previous: branch.last!, direction: -(branchAngle/2) + branch.last!.direction.wobble(branchWobble), type: .regular)]
                        updatedTree.append(newBranch)
                        updatedTree.append(newBranch2)
                        staticBranches.append(branch)
                    case .end:
                        staticBranches.append(branch)
                    default:
                        updatedTree.append(extend(branch: branch, wobble: wobble, branchFrequency: branchFrequency))
                }
            } else {
                staticBranches.append(branch)
            }
        }
    }
    tree = updatedTree
}


