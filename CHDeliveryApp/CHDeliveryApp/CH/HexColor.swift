//
//  HexColor.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/03.
//

import SwiftUI


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0.8...1),
            green: .random(in: 0.8...1),
            blue: .random(in: 0.8...1)
        )
    }
}
