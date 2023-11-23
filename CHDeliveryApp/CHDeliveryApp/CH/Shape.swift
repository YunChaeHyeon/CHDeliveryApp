//
//  Shape.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/03.
//

import SwiftUI

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

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
