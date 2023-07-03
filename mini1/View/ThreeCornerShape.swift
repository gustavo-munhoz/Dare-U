//
//  ThreeCornerShape.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 02/07/23.
//

import SwiftUI

struct ThreeCornersShape: Shape {
    let cornerRadius: CGFloat
    let corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}
