//
//  Shape.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/03.
//

import SwiftUI


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct borderStyleView : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
          .strokeBorder(
            LinearGradient(
              gradient: .init(
                colors: [
                  Color.mint,
                  Color(red: 226 / 255.0, green: 247 / 255.0, blue: 5 / 255.0)
                ]
              ),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
            //lineWidth: isEditing ? 4 : 2
          )
    }
}
