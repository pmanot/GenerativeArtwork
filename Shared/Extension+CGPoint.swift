//
//  Extension+CGPoint.swift
//  GenerativeArt
//
//  Created by Purav Manot on 09/11/21.
//

import Foundation
import SwiftUI

extension CGPoint {
    func step(angle: CGFloat, radius: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + cos(angle)*radius*2, y: self.y + sin(angle)*radius*2)
    }
}

extension CGFloat {
    func wobble(_ value: CGFloat) -> Self {
        return self + CGFloat.random(in: -value...value)
    }
}
