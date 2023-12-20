//
//  ExtensionView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 12/19/23.
//

import SwiftUI

//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
