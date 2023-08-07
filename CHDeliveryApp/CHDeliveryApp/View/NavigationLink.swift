//
//  NavigationLink.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/07.
//

import SwiftUI

struct NavBackButton: View {
    let dismiss: DismissAction
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("...custom back button here")
        }
    }
}
